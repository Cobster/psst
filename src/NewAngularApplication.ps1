function New-AngularApplication {
<#

.SYNOPSIS

.PARAMETER Name
    The name of the angular application. A new folder with this name will be created 
    and will be filled with all the development artifacts needed to create a modern
    client-side application.

.PARAMETER Title
    The title of the application.

.PARAMETER ArtifactsFolder
    Optional path that will used for the output of build artifacts.

.PARAMETER BaseUrl
    Optional path that is the root of the angular application. Default value is '/'. 

.PARAMETER SourceFolder
    Optional path that will be used to store the angular application source files.

.PARAMETER Version
    Optional version of the angular application. Defaults to "1.0.0".

#>
    [CmdletBinding()]
    param (
        [string] $Name,
        [string] $Title = $Name,
        [string] $Styles,
        [string] $ArtifactsFolder = 'dist',
        [string] $BaseUrl = '/',
        [string] $SourceFolder = 'src',
        [string] $Version = '1.0.0'
    )

    $TemplateDir = "$PsstTemplateRoot\angular2\app"

    $Model = @{

        Name = (Get-NamingConventions $Name)
        TemplateDir = "$PsstTemplateRoot\angular2\app"
        Title = $Title
        ArtifactsFolder = $ArtifactsFolder
        BaseUrl = $BaseUrl
        SourceFolder = $SourceFolder
        Version = $Version
    }

    Expand-TemplateDirectory -InputPath $TemplateDir -Model $Model

}