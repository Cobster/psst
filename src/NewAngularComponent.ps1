<#

.SYNOPSIS
    Creates a set of artifacts that comprise an Angular2 component.

.PARAMETER Selector

.PARAMETER Styles

.PARAMETER NoSelector
    Use this switch when you do not want a component to be declaratively added to the template
    of another component. This is common for components that should only be accessible via a route.

#>
function New-AngularComponent {

    param (
        [string] $Name,
        [string] $Prefix,
        [string] $Styles,
        [switch] $NoSelector
    )

    $__Name = Get-NamingConventions -Name $Name

    $Stereotype = "component"
    
    $ComponentMetadata = @()

    # Omit the selector when -NoSelector is specified, this is useful when 
    # you do not want a component to be declaratively added to template. 
    # This is common for route-only components
    if (-not ($NoSelector.IsPresent)) {
        $ComponentMetadata += "selector: '$Prefix-$($__Name.KebabCase)'"
    }
    
    $ComponentMetadata += "template: require('./$($__Name.KebabCase).component.html')"

    if (-not [String]::IsNullOrWhiteSpace($Styles)) {

        $Extension = $Styles.ToLower()
        if ($Extension -eq 'sass') {
            $Extension = 'scss'
        }

        $ComponentMetadata += Expand-Template -Path "$PSScriptRoot\templates\angular2\component.styles-metadata.psst" `
            -Name $__Name -Extension $Extension -Sterotype $Sterotype

        Expand-Template -Path "$PSScriptRoot\templates\angular2\component.styles.psst" `
            -OutFile "$pwd\$($__Name.KebabCase).$Stereotype.$Extension"
             
    }

    $ComponentDecorator = Expand-Template -Path "$PSScriptRoot\templates\angular2\component.decorator.psst" -ComponentMetadata $ComponentMetadata
    
    Expand-Template -Path "$PSScriptRoot\templates\angular2\component.ts.psst" `
        -OutFile "$pwd\$($__Name.KebabCase).component.ts" `
        -Name $__Name `
        -ComponentDecorator $ComponentDecorator

          
    Expand-Template -Path "$PSScriptRoot\templates\angular2\component.html.psst" `
        -OutFile "$pwd\$($__Name.KebabCase).component.html" `
        -Name $__Name

    Expand-Template -Path "$PSScriptRoot\templates\angular2\component.spec.psst" `
        -OutFile "$pwd\$($__Name.KebabCase).component.spec.ts" `
        -Name $__Name
}