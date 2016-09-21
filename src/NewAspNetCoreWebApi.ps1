function New-AspNetCoreWebApi {

    param (
        [string] $Name
    )

    $TemplateDir = "$PsstTemplateRoot\aspnetcore\webapi"

    $Model = @{
        TemplateDir = "$PsstTemplateRoot\aspnetcore\webapi"
        Name = (Get-NamingConventions -Name $Name)
    }

    Expand-TemplateDirectory -InputPath $TemplateDir -Model $Model
}