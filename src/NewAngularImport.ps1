function New-AngularImport
{
    param (
        [string[]] $Imports,
        [string] $Path
    )

    Expand-Template `
        -InputFile "$PSScriptRoot\templates\angular2\import.psst" `
        -Imports $Imports `
        -Path $Path
}