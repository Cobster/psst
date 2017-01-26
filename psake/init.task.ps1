
Task 'init' `
    -description "Creates the release directory if it doesn't already exist." `
    -requiredVariable OutputDir, ProjectDir `
    -postcondition { Test-Path $OutputDir } `
{ 
    if (-not (Test-Path $OutputDir)) {
        Write-Host "Creating: $OutputDir"
        New-Item $OutputDir -ItemType Directory -Verbose:$VerbosePreference | Out-Null
    }
}
