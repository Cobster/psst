<#

This is a psake build automation script. 


#>

Properties {

    `$SrcDir = "`$PSScriptRoot/src"
    `$TestDir = "`$PSScriptRoot/src"

    # This should match the name of the PSD1 file for the module.
    `$ModuleName = Get-Item `$SrcDir/*.psd1 |
        Where-Object { `$null -ne (Test-ModuleManifest -Path `$_ -ErrorAction SilentlyContinue )} |
        Select-Object -First 1 -ExpandProperty BaseName
    `$ReleaseDir = "`$PSScriptRoot/release"
    `$OutputDir = "`$ReleaseDir/`$ModuleName"
    `$Exclude = @("*.Tests.ps1")

    `$TestFailureMessage = "One or more tests failed, build will not continue."
}

Task default -depends Build

#
# INIT
# 
Task Init ``
    -description "Creates the release directory if it doesn't already exist." ``
    -RequiredVariable OutputDir ``
{ 
    if (-not ((Test-Path `$OutputDir) -and `$OutputDir.StartsWith(`$PSScriptRoot, 'OrdinalIgnoreCase'))) {
        New-Item `$OutputDir -ItemType Directory | Out-Null
    }
}


#
# CLEAN
#
Task Clean ``
    -description "Deletes the contents of the release directory." ``
    -requiredVariables ReleaseDir `` 
{
    if ((Test-Path `$ReleaseDir) -and `$ReleaseDir.StartsWith(`$PSScriptRoot, 'OrdinalIgnoreCase')) {
        Get-ChildItem `$ReleaseDir | Remove-Item -Recurse -Force -Verbose:`$VerbosePreference
    }
}

#
# BUILD
#
Task Build ``
    -description "This copies all the powershell code and scaffolding templates to the ```$OutputDir." ``
    -depends Init, Clean ``
{
    # Copy all the scripts into the release directory
    Copy-Item -Path `$SrcDir -Destination `$OutputDir -Recurse -Exclude `$Exclude -Verbose:`$VerbosePreference
}


#
# TEST
#
Task Test ``
    -description "This runs the Pester unit tests." ``
    -requiredVariables TestDir, ModuleName, TestFailureMessage ``
{
    Import-Module Pester

    try {
        Push-Location `$TestDir

        `$TestResult = Invoke-Pester -PassThru -Verbose:`$VerbosePreference

        Assert (`$TestResult.FailedCount -eq 0) `$TestFailureMessage
    }
    finally {
        Pop-Location
        Remove-Module `$ModuleName 
    }
}