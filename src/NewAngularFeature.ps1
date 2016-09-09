function New-AngularFeature
{
    param (
        [string] $Name,
        [switch] $Routing
    )

    $TemplateDir = "$PSScriptRoot\templates\angular2\feature"

    $__Name = Get-NamingConventions -Name $Name

    # Create a new directory to house the feature
    New-Item $__Name.Lowercase -ItemType Directory

    # Create a new bundle file to export the feature contents
    Expand-Template -Path "$TemplateDir\index.ts.psst" `
        -OutFile "$($__Name.Lowercase)\index.ts" 
    
    # Create the module file
    Expand-Template -Path "$TemplateDir\module.ts.psst" `
        -OutFile "$($__Name.Lowercase)\$($__Name.KebabCase).module.ts" `
        -Name $__Name

    if ($Routing) {
        Expand-Template -Path "$TemplateDir\routing.ts.psst" `
            -OutFile "$($__Name.Lowercase)\$($__Name.KebabCase).routing.ts" `
            -Name $__Name

        # need to add to bundle
        # need to import in module
    } 

    # Create a bundle
    # Create a module

    # Create a routing module 
}