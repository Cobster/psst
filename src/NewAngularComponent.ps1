<#

.SYNOPSIS
    Creates a set of artifacts that comprise an Angular2 component.

.PARAMETER Name
    The name of the angular component that will be created.

.PARAMETER Selector
    The selector to use for the component.

.PARAMETER Styles
    The type of styling file to create. Specified as 'css', 'sass', or 'less'.
    
.PARAMETER NoSelector
    Use this switch when you do not want a component to be declaratively added to the template
    of another component. This is common for components that should only be accessible via a route.

#>
function New-AngularComponent {

    param (
        [Parameter(Mandatory = $true)]
        [string] $Name,
        [string] $Prefix,
        [string] $Selector,
        [string] $Styles
    )

    $__Name = Get-NamingConventions -Name $Name

    $Stereotype = "component"
    $TypescriptExtension = "ts"
    $TestExtension = "spec.ts"
    $HtmlExtension = "html"
    $TemplateDir = "$PSScriptRoot\templates\angular2"
    
    $ComponentMetadata = @()

    # Add the 'selector' to the component decorator metadata
    if (-not ([String]::IsNullOrWhitespace($Selector))) {
        $ComponentMetadata += Expand-Template -Path "$TemplateDir\component.metadata.selector.psst" `
            -Selector $Selector -Name $__Name -Stereotype $Stereotype -Extension $TypescriptExtension
    }

    # Add the 'template' component decorator metadata
    $ComponentMetadata += Expand-Template -Path "$TemplateDir\component.metadata.template.psst" `
        -Name $__Name -Stereotype $Stereotype -Extension $TypescriptExtension
    
    # Add a style file and 'styles' to the component decorator metadata
    if (-not [String]::IsNullOrWhiteSpace($Styles)) {

        $StylesExtension = $Styles.ToLower()
        if ($StylesExtension -eq 'sass') {
            $StylesExtension = 'scss'
        }

        $ComponentMetadata += Expand-Template -Path "$TemplateDir\component.metadata.styles.psst" `
            -Name $__Name -Extension $StylesExtension -Sterotype $Stereotype

        Expand-Template -Path "$TemplateDir\component.styles.psst" `
            -OutFile "$pwd\$($__Name.KebabCase).$Stereotype.$StylesExtension"
             
    }

    $ComponentDecorator = Expand-Template -Path "$TemplateDir\component.decorator.psst" -ComponentMetadata $ComponentMetadata
    
    Expand-Template -Path "$TemplateDir\component.ts.psst" `
        -OutFile "$pwd\$($__Name.KebabCase).$Stereotype.$TypescriptExtension" `
        -Name $__Name `
        -ComponentDecorator $ComponentDecorator
          
    Expand-Template -Path "$TemplateDir\component.html.psst" `
        -OutFile "$pwd\$($__Name.KebabCase).$Stereotype.$HtmlExtension" `
        -Name $__Name

    Expand-Template -Path "$TemplateDir\component.spec.psst" `
        -OutFile "$pwd\$($__Name.KebabCase).$Stereotype.$TestExtension" `
        -Name $__Name
}