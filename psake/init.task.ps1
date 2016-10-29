
Task Init `
    -description "Creates the release directory if it doesn't already exist." `
    -requiredVariable OutputDir, ProjectDir `
{ 
    if (-not (Test-Path $OutputDir)) {
        New-Item $OutputDir -ItemType Directory -Verbose:$VerbosePreference | Out-Null
    }
}
