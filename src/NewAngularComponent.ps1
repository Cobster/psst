function New-AngularComponent {

    param (
        [string]$Name,
        [string]$Prefix
    )

    $__Name = Get-NamingConventions -Name $Name
    $__TypescriptTemplate = Get-Content -Path "$PSScriptRoot\templates\angular2\component.ts.psst" -Raw

    Expand-Template $__TypescriptTemplate -Name $__Name -Prefix $Prefix | Out-File -FilePath "$pwd\$($Names.KebabCase).component.ts" 

    $__HtmlTemplate = Get-Content -Path "$PSScriptRoot\templates\angular2\component.html.psst" -Raw
    Expand-Template $__HtmlTemplate -Name $__Name | Out-File

}