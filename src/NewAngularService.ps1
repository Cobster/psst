function New-AngularService {

    param (
        [string] $Name
    )

    $TemplateDirectory = "$PSScriptRoot\templates\angular2\service"

    $__Name = Get-NamingConventions $Name

    Expand-Template -InputFile "$TemplateDirectory\service.ts.psst" -OutputFile "$pwd\$($__Name.KebabCase).service.ts" -Name $__Name
    Expand-Template -InputFile "$TemplateDirectory\service.spec.psst" -OutputFile "$pwd\$($__Name.KebabCase).service.spec.ts" -Name $__Name
}

