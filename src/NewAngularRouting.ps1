function New-AngularRouting
{
    param (
        [string] $Name,
        [switch] $Root
    )

    $TemplateDir = "$PSScriptRoot\templates\angular2\routing"

    $Model = @{
        Name = (Get-NamingConventions -Name $Name)
        Target = "Child"
    }

    if ($Root) {
        $Model.Target = 'Root'
    }

    Expand-Template -InputFile "$TemplateDir\routing.ts" -Model $Model 
}