
$PsstTemplateRoot = "$PSScriptRoot\templates"

$Psst = Import-PowerShellDataFile "$PSScriptRoot\psst.psd1"

. $PSScriptRoot\ConvertToKebabCase.ps1
. $PSScriptRoot\ExpandTemplate.ps1
. $PSScriptRoot\GetNamingConventions.ps1
. $PSScriptRoot\ExpandTemplateDirectory.ps1

. $PSScriptRoot\NewPsstGenerator.ps1
. $PSScriptRoot\NewPsstGeneratorModule.ps1

. $PSScriptRoot\NewExport.ps1
. $PSScriptRoot\NewImport.ps1
. $PSScriptRoot\NewMetadata.ps1

. $PSScriptRoot\NewAngularApplication.ps1
. $PSScriptRoot\NewAngularComponent.ps1
. $PSScriptRoot\NewAngularFeature.ps1
. $PSScriptRoot\NewAngularService.ps1
. $PSScriptRoot\NewAngularRouting.ps1

. $PSScriptRoot\NewAspNetCoreWebApi.ps1

Export-ModuleMember -Function *-* 