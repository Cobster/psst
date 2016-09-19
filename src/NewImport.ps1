function New-Import
{
    param (
        [string[]] $Imports,
        [string] $Path
    )

    Expand-Template `
        -InputFile "$PSScriptRoot\templates\angular2\import.ts" `
        -Imports $Imports `
        -Path $Path
}