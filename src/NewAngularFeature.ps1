function New-AngularFeature
{
    param (
        [string] $Name,
        [switch] $Routing
    )

    $TemplateDir = "$PSScriptRoot\templates\angular2\feature"

    $__Name = Get-NamingConventions -Name $Name

    $BundleExportList = @()
    
    $ModuleImports = @()
    $ModuleMetadataDeclarations = @()
    $ModuleMetadataImports = @()
    $ModuleMetadataExports = @()
    $ModuleMetadataProviders = @()
    $ModuleMetadata = @()
    
    # Create a new directory to house the feature
    New-Item $__Name.Lowercase -ItemType Directory

    # Import NgModule
    $ModuleImports += Expand-Template -InputFile "$TemplateDir\import.psst" -Path '@angular/core' -Imports NgModule
    
    # Import CommonModule
    $ModuleImports += Expand-Template -InputFile "$TemplateDir\import.psst" -Path '@angular/common' -Imports CommonModule
    $ModuleMetadataImports += "CommonModule"

    if ($Routing) {
        Expand-Template -InputFile "$TemplateDir\routing.ts.psst" `
            -OutputFile "$($__Name.Lowercase)\$($__Name.KebabCase).routing.ts" `
            -Name $__Name

        # Add the routing module to the bundle export list
        
        $BundleExportList += Expand-Template -InputFile "$TemplateDir\index.export.psst" -Path "./$($__Name.KebabCase).routing"
        
        $ModuleImports += Expand-Template -InputFile "$TemplateDir\import.psst" -Path "./$($__Name.KebabCase).routing" -Imports @("$($__Name)Routing","$($__Name)RoutingProviders")
        $ModuleMetadataImports += "$($__Name)Routing" 
        $ModuleMetadataProviders += "$($__Name)RoutingProviders"
        # need to import in module
    }

    # Construct the NgModule metadata
    $ModuleMetadata += Expand-Template -InputFile "$TemplateDir\module.metadata.declarations.psst" -Declarations $ModuleMetadataDeclarations 
    $ModuleMetadata += Expand-Template -InputFile "$TemplateDir\module.metadata.imports.psst" -Imports $ModuleMetadataImports 
    $ModuleMetadata += Expand-Template -InputFile "$TemplateDir\module.metadata.exports.psst" -Exports $ModuleMetadataExports
    $ModuleMetadata += Expand-Template -InputFile "$TemplateDir\module.metadata.providers.psst" -Providers $ModuleMetadataProviders

    # Create the module file
    Expand-Template -InputFile "$TemplateDir\module.ts.psst" `
        -OutputFile "$($__Name.Lowercase)\$($__Name.KebabCase).module.ts" `
        -Name $__Name `
        -Imports $ModuleImports `
        -ModuleMetadata $ModuleMetadata
    
    # Add the module to the bundle export list
    $BundleExportList += Expand-Template -InputFile "$TemplateDir\index.export.psst" -Path "./$($__Name.KebabCase).module"

    # Create a new bundle file to export the feature contents
    Expand-Template -InputFile "$TemplateDir\index.ts.psst" `
        -OutputFile "$($__Name.Lowercase)\index.ts" `
        -Exports $BundleExportList
}