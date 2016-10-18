
Properties {

    $SrcDir = "$PSScriptRoot/src"
    $TestDir = "$PSScriptRoot/src"

    # This should match name of the PSD1 file. 
    $ModuleName = Get-Item $SrcDir/*.psd1 | 
        Where-Object { $null -ne (Test-ModuleManifest -Path $_ -ErrorAction SilentlyContinue) } |
        Select-Object -First 1 -ExpandProperty BaseName 

    $ReleaseDir = "$PSScriptRoot/release"
    $OutputDir = "$ReleaseDir/$ModuleName"
    $Exclude = @("*.Tests.ps1")
}


#
# INIT
# 
Task Init -RequiredVariable OutputDir -Description "Creates the release directory if it doesn't already exist." {
    if (-not ((Test-Path $OutputDir) -and $OutputDir.StartsWith($PSScriptRoot, 'OrdinalIgnoreCase'))) {
        New-Item $OutputDir -ItemType Directory | Out-Null
    }
}


#
# CLEAN
#
Task Clean -RequiredVariables ReleaseDir -Description "Deletes the contents of the release directory." {
    if ((Test-Path $ReleaseDir) -and $ReleaseDir.StartsWith($PSScriptRoot, 'OrdinalIgnoreCase')) {
        Get-ChildItem $ReleaseDir | Remove-Item -Recurse -Force -Verbose:$VerbosePreference
    }
}


#
# BUILD
#
Task Build -Depends Init, Clean {
    # Copy all the scripts into the release directory
    Copy-Item -Path $SrcDir -Destination $OutputDir -Recurse -Exclude $Exclude -Verbose:$VerbosePreference
}


#
# TEST
#
Task Test -requiredVariables TestDir, ModuleName {
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