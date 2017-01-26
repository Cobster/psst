#
# INIT
# 
Task 'init' ``
    -description "Creates the release directory if it doesn't already exist." ``
    -RequiredVariable OutputDir ``
{ 
    if (-not (Test-Path `$OutputDir)) {
        New-Item `$OutputDir -ItemType Directory | Out-Null
    }
}
