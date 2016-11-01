
Properties {
    
    if ([string]::IsNullOrWhitespace($Version)) {
        $Version = "0.0.0"
    }


    $ModuleName = "Psst"
    $Authors = "Jake Bruun"

    $ProjectDir = "$PSScriptRoot"

    $SrcDir = "$ProjectDir\src"
    $TestDir = "$ProjectDir\src"
    $TestResults = "PesterTestResults.xml"

    $ReleaseDir = "$ProjectDir\bin\release"
    $OutputDir = "$ReleaseDir\$ModuleName"

    

    $ExamplesDir = "$ReleaseDir\examples"

    $Exclude = @("*.Tests.ps1")

    $TemplateCache = "$env:LOCALAPPDATA\$ModuleName\$Version"

    $ReleaseNotes = "https://github.com/Cobster/psst/blob/master/ReleaseNotes.md"

    $SettingsPath = "$env:LOCALAPPDATA\$ModuleName\SecuredBuildSettings.clixml"

    $NoBuildOutputErrorMessage = "There is no build output. Run psake build."
    $CodeCoverage = $true

    # Git 

    $GitLastCommit = git rev-parse HEAD
    $GitHash = $GitLastCommit.Substring(0,7)

    # Publishing
    $NuGetApiKey = $null
    $PublishRepository = $null
    
    
    # Define the options for artifact archival

    $ZipArtifactsOptions = @{
        InputFilePath = @("$OutputDir","$ReleaseDir\$TestResults")
        OutputFilePath = "$ReleaseDir"
        OutputFileFormat = "$ModuleName-$Version-$GitHash.zip"
    }

}

. $PSScriptRoot\psake\tasks.ps1