
Properties {

    $SrcDir = "$PSScriptRoot\src"
    $TestDir = "$PSScriptRoot\src"

    # This should match name of the PSD1 file. 
    $ModuleName = Get-Item $SrcDir/*.psd1 | 
        Where-Object { $null -ne (Test-ModuleManifest -Path $_ -ErrorAction SilentlyContinue) } |
        Select-Object -First 1 -ExpandProperty BaseName 

    $ReleaseDir = "$PSScriptRoot\release"
    $OutputDir = "$ReleaseDir\$ModuleName"
    $Exclude = @("*.Tests.ps1")

    $SettingsPath = "$env:LOCALAPPDATA\Psst\SecuredBuildSettings.clixml"

    $NoBuildOutputErrorMessage = "There is no build output. Run psake build."
    $CodeCoverage = $true

    # Publishing
    $NuGetApiKey = $null
    $PublishRepository = $null

}


. $PSScriptRoot\build-publishing.ps1
. $PSScriptRoot\build-settings.ps1

Task default -depends Build

#
# INIT
# 
Task Init `
    -description "Creates the release directory if it doesn't already exist." `
    -requiredVariables OutputDir `
{

    if (-not ((Test-Path $OutputDir) -and $OutputDir.StartsWith($PSScriptRoot, 'OrdinalIgnoreCase'))) {
        New-Item $OutputDir -ItemType Directory | Out-Null
    }
}


#
# CLEAN
#
Task Clean `
    -description "Deletes the contents of the release directory." `
    -requiredVariables ReleaseDir `
{

    if ((Test-Path $ReleaseDir) -and $ReleaseDir.StartsWith($PSScriptRoot, 'OrdinalIgnoreCase')) {
        Get-ChildItem $ReleaseDir | Remove-Item -Recurse -Force -Verbose:$VerbosePreference
    }
}


#
# BUILD
#
Task Build `
    -description "This copies all the powershell code and scaffolding templates to $OutputDir." `
    -depends Init, Clean `
{
    # Copy all the scripts into the release directory
    Copy-Item -Path $SrcDir -Destination $OutputDir -Recurse -Exclude $Exclude -Verbose:$VerbosePreference
}

#
# TEST
#
Task Test `
    -description "Runs all of the unit tests with pester." `
    -requiredVariables TestDir, ModuleName `
{
    Import-Module Pester

    try {
        Push-Location $TestDir

        $TestResult = Invoke-Pester -PassThru -Verbose:$VerbosePreference

        Assert ($TestResult.FailedCount -eq 0) "One or more tests failed, build will not continue."
    }
    finally {
        Pop-Location
        Remove-Module $ModuleName
    }
}

Task Publish `
    -description "Publishes the module to PowerShellGallery." `
    -requiredVariables SettingsPath, OutputDir `
{
    $publishParams = @{
        Path        = $OutputDir
        NuGetApiKey = $NuGetApiKey
    }

    # Publishing to the PSGallery requires an API key, so get it.
    if ($NuGetApiKey) {
        "Using script embedded NuGetApiKey"
    }
    elseif ($NuGetApiKey = GetSetting -Path $SettingsPath -Key NuGetApiKey) {
        "Using stored NuGetApiKey"
    }
    else {
        $promptForKeyCredParams = @{
            DestinationPath = $SettingsPath
            Message         = 'Enter your NuGet API key in the password field'
            Key             = 'NuGetApiKey'
        }

        $cred = PromptUserForCredentialAndStorePassword @promptForKeyCredParams
        $NuGetApiKey = $cred.GetNetworkCredential().Password
        "The NuGetApiKey has been stored in $SettingsPath"
    }

    $publishParams = @{
        Path        = $OutputDir
        NuGetApiKey = $NuGetApiKey
    }

    # If an alternate repository is specified, set the appropriate parameter.
    if ($PublishRepository) {
        $publishParams['Repository'] = $PublishRepository
    }

    # Consider not using -ReleaseNotes parameter when Update-ModuleManifest has been fixed.
    if ($ReleaseNotesPath) {
        $publishParams['ReleaseNotes'] = @(Get-Content $ReleaseNotesPath)
    }

    "Calling Publish-Module..."
    Publish-Module @publishParams
}


#
# IMPORT
#
Task "Import" `
    -description "Imports the module under development into the current powershell session" `
    -requiredVariables ModuleName, OutputDir `
{
    Assert -conditionToCheck (Test-Path $OutputDir) $NoBuildOutputErrorMessage

    if ($null -ne (Get-Module -Name $ModuleName)) {
        Write-Host "Removing $ModuleName"
        Remove-Module $ModuleName
    } 

    $ImportPath = (Resolve-Path $OutputDir)
    Write-Host "Importing $ModuleName from $ImportPath"
    Import-Module $ImportPath
}

#
# INSTALL
# 
Task Install `
    -description "Copies the release module into the current users PowerShell module path." `
    -requiredVariables ModuleName, OutputDir `
{
    AssertBuildOutputExists

    $UserModulePath = "$env:HOME\Documents\WindowsPowerShell\Modules\Psst"
    if (Test-Path $UserModulePath) {
        Write-Host "Removing $UserModulePath"
        Remove-Item $UserModulePath -Force -Recurse
    }

    Write-Host "Copying $OutputDir to $UserModulePath"    
    Copy-Item $OutputDir -Destination $UserModulePath  -Recurse
}

#
# UNINSTALL
#
Task Uninstall `
    -description "Removes the module from the current users PowerShell module path." `
    -requiredVariables ModuleName, OutputDir `
{
    AssertBuildOutputExists

    $UserModulePath = "$env:HOME\Documents\WindowsPowerShell\Modules\Psst"
    if (Test-Path $UserModulePath) {
        Write-Host "Removing $UserModulePath"
        Remove-Item $UserModulePath -Force -Recurse
    }
}

function AssertBuildOutputExists { 
    Assert -conditionToCheck (Test-Path $OutputDir) $NoBuildOutputErrorMessage
}