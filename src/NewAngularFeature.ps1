function New-AngularFeature
{
    param (
        [string] $Name,
        [switch] $Routing
    )

    $TemplateDir = "$PSScriptRoot\templates\angular2\feature"

    $Model = @{
        Name = (Get-NamingConventions -Name $Name)
        
        Bundle = @{
            Exports = @()
        }

        Module = @{
            Imports = @()
            Metadata = @{
                Declarations = @()
                Exports = @()
                Imports = @()
                Providers = @()
            }
        }
    }
   
    # Create a new directory to house the feature
    New-Item $Model.Name.Lowercase -ItemType Directory

    # Import NgModule
    $Model.Module.Imports += New-Import -Imports 'NgModule' -Path '@angular/core'
    
    # Import CommonModule
    $Model.Module.Imports += New-Import -Imports @('CommonModule') -Path '@angular/common'
    $Model.Module.Metadata.Imports += "CommonModule"

    # Add the module to the bundle export list
    $Model.Bundle.Exports += New-Export -Path "./$($Model.Name.KebabCase).module" 
    
    if ($Routing) {
        # Add the routing module to the bundle export list
        $Model.Bundle.Exports = New-Export -Path "./$($Model.Name.KebabCase).routing" 

        # Import the routing module and providers
        $Model.Module.Imports += New-Import -Imports @("$($Model.Name)Routing","$($Model.Name)RoutingProviders") -Path "./$($Model.Name.KebabCase).routing"
        $Model.Module.Metadata.Imports += "$($Model.Name)Routing"
        $Model.Module.Metadata.Providers += "$($Model.Name)RoutingProviders"
    }

    # Create the module file
    Expand-Template `
        -InputFile "$TemplateDir\module.ts" `
        -OutputFile "$($Model.Name.KebabCase)\$($Model.Name.KebabCase).module.ts" `
        -Model $Model.Module
    
    # Create a new bundle file to export the feature contents
    Expand-Template -InputFile "$TemplateDir\index.ts" `
        -OutputFile "$($Model.Name.KebabCase)\index.ts" `
        -Model $Model.Bundle

    # Create the routing file 
    if ($Routing) {
        Expand-Template `
            -InputFile "$TemplateDir\routing.ts" `
            -OutputFile "$($Model.Name.KebabCase)\$($Model.Name.KebabCase).routing.ts" `
            -Model $Model
    }
}