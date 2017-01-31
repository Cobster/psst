<#

This is a psake build automation script. 

#>

Properties {
    `$Authors = "`$env:USERNAME","and contributors"

    `$SrcDir = "`$PSScriptRoot\src"
    `$TestDir = "`$PSScriptRoot"
    `$TestResults = "PesterTestResults.xml"

    # This should match the name of the PSD1 file for the module.
    `$ModuleName = "$($Model.FullName)"
    `$ReleaseDir = "`$PSScriptRoot\bin\release"
    `$OutputDir = "`$ReleaseDir\`$ModuleName"
    `$Exclude = @("*.Tests.ps1")

    `$LocalModuleDataDir = "`$env:LOCALAPPDATA\`$ModuleName\"


    `$TemplateCache = "`$LocalModuleDataDir\`$Version"
    `$ReleaseNotes = ""

    `$SettingsPath = "`$LocalModuleDataDir\SecuredBuildSettings.clixml"

    `$NoBuildOutputErrorMessage = "There is no build output. Run psake build."
    `$TestFailureMessage = "One or more tests failed, build will not continue."

    `$NuGetApiKey = `$null
    `$PublishRepository = `$null

    if ([string]::IsNullOrWhitespace(`$Version)) {
        `$Version = "0.0.0"
    }
}

. `$PSScriptRoot\psake\tasks.ps1