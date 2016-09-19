function New-Metadata
{
    param (
        [string] $Metadata,
        [string[]] $Model
    )

    Expand-Template `
        -InputFile "$PSScriptRoot\templates\angular2\metadata.ts" `
        -Name $Metadata `
        -Model $Model
}

# This really isn't metadata.  It is simply a javascript array property.