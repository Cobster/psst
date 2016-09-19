
$Psst = Import-PowerShellDataFile "$PSScriptRoot\psst.psd1"

. $PSScriptRoot\ConvertToKebabCase.ps1
. $PSScriptRoot\ExpandTemplate.ps1
. $PSScriptRoot\GetNamingConventions.ps1

. $PSScriptRoot\NewImport.ps1
. $PSScriptRoot\NewMetadata.ps1

. $PSScriptRoot\NewAngularApplication.ps1
. $PSScriptRoot\NewAngularComponent.ps1
. $PSScriptRoot\NewAngularFeature.ps1
. $PSScriptRoot\NewAngularService.ps1

Export-ModuleMember -Function *-* 