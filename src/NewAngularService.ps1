function New-AngularService {
<#

.PARAMETER Http
    This flag indicates that the service is dependent on the Angular Http service.
#>
    param (
        [string] $Name,
        [switch] $Http
    )

    $TemplateDirectory = "$PSScriptRoot\templates\angular2\service"

    $Model = @{
        Name = (Get-NamingConventions $Name)
        Imports = @()
        Constructor = @{
            Arguments = @()
        }
    }

    $Model.Imports += New-Import -Imports @('Injectable') -Path '@angular/core' 

    if ($Http) {
        $Model.Imports += New-Import -Imports Http -Path '@angular/http'
        $Model.Constructor.Arguments += "private http: Http"
    }

    Expand-Template -InputFile "$TemplateDirectory\service.ts" -OutputFile "$pwd\$($Model.Name.KebabCase).service.ts" -Model $Model
    Expand-Template -InputFile "$TemplateDirectory\service.spec.ts" -OutputFile "$pwd\$($Model.Name.KebabCase).service.spec.ts" -Model $Model
}

