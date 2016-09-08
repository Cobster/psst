
function New-AngularComponent {

    param (
        [string] $Name,
        [string] $Prefix,
        [string] $Styles,
        [switch] $NoSelector
    )

    $__Name = Get-NamingConventions -Name $Name

    $ComponentMetadata = @()

    # Omit the selector when -NoSelector is specified, this is useful when 
    # you do not want a component to be declaratively added to template. 
    # This is common for route-only components
    if (-not ($NoSelector.IsPresent)) {
        $ComponentMetadata += "selector: '$Prefix-$($__Name.KebabCase)'"
    }
    
    $ComponentMetadata += "template: require('./$($__Name.KebabCase).component.html')"

    if (-not [String]::IsNullOrWhiteSpace($Styles)) {
        switch ($Styles.ToLower()) {
                
                "css" {
                    $CssTemplate = Get-Content -Path "$PSScriptRoot\templates\angular2\component.css.psst" -Raw
                    Expand-Template $CssTemplate -Name $__Name | Out-File -FilePath "$pwd\$($__Name.KebabCase).component.css"
                    $ComponentMetadata += "styles: [require('./$($__Name.KebabCase).component.css')]"
                }

                "less" {
                    $LessTemplate = Get-Content -Path "$PSScriptRoot\templates\angular2\component.less.psst" -Raw
                    Expand-Template $LessTemplate -Name $__Name | Out-File -FilePath "$pwd\$($__Name.KebabCase).component.less"
                    $ComponentMetadata += "styles: [require('./$($__Name.KebabCase).component.less')]"
                }


                { $_ -eq "sass" -or $_ -eq "scss" } {
                    $SassTemplate = Get-Content -Path "$PSScriptRoot\templates\angular2\component.scss.psst" -Raw
                    Expand-Template $SassTemplate -Name $__Name | Out-File -FilePath "$pwd\$($__Name.KebabCase).component.scss"
                    $ComponentMetadata += "styles: [require('./$($__Name.KebabCase).component.scss')]"
                }
            }
    }
    

    $ComponentDecorator = "@Component({`r`n$([String]::Join(",`r`n`t", $ComponentMetadata))`r`n})"

    $__TypescriptTemplate = Get-Content -Path "$PSScriptRoot\templates\angular2\component.ts.psst" -Raw

    Expand-Template $__TypescriptTemplate -Name $__Name -ComponentDecorator $ComponentDecorator | Out-File -FilePath "$pwd\$($__Name.KebabCase).component.ts" 

    $__HtmlTemplate = Get-Content -Path "$PSScriptRoot\templates\angular2\component.html.psst" -Raw
    Expand-Template $__HtmlTemplate -Name $__Name | Out-File -FilePath "$pwd\$($__Name.KebabCase).component.html"
}