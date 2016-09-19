function New-Export
{
    param (
        [string] $Path
    )

    Expand-Template `
        -InputFile "$PSScriptRoot\templates\angular2\export.ts" `
        -Path $Path
}