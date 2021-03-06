
$PsstTemplateRoot = "$PSScriptRoot\templates"

$Psst = Import-PowerShellDataFile "$PSScriptRoot\psst.psd1"
$ModuleData = Import-PowerShellDataFile "$PSScriptRoot\psst.psd1"

. $PSScriptRoot\ConvertToKebabCase.ps1
. $PSScriptRoot\GetNamingConventions.ps1
. $PSScriptRoot\ExpandTemplate.ps1
. $PSScriptRoot\ExpandTemplateDirectory.ps1

. $PSScriptRoot\NewPsstGenerator.ps1
. $PSScriptRoot\NewPsstGeneratorModule.ps1

Export-ModuleMember -Function *-* 