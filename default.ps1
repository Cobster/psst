
Properties {
    
    $ModuleName = "Psst"
    $Authors = "Jake Bruun"

    $ProjectDir = "$PSScriptRoot"

    $SrcDir = "$ProjectDir\src"
    $TestDir = "$ProjectDir\src"
    $TestResults = "PesterTestResults.xml"

    $ReleaseDir = "$ProjectDir\bin\release"
    $OutputDir = "$ReleaseDir\$ModuleName"

    $Exclude = @("*.Tests.ps1")

    $TemplateCache = "$env:LOCALAPPDATA\$ModuleName\$Version"

    $ReleaseNotes = "https://github.com/Cobster/psst/blob/master/ReleaseNotes.md"

    $SettingsPath = "$env:LOCALAPPDATA\$ModuleName\SecuredBuildSettings.clixml"

    $NoBuildOutputErrorMessage = "There is no build output. Run psake build."
    $CodeCoverage = $true

    # Publishing
    $NuGetApiKey = $null
    $PublishRepository = $null

    if ([string]::IsNullOrWhitespace($Version)) {
        $Version = "0.0.0"
    }
}

. $PSScriptRoot\psake\tasks.ps1