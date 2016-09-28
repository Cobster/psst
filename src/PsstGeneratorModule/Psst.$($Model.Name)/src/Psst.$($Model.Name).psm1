
`$ModuleData = Import-PowerShellDataFile "`$PSScriptRoot\$($Model.Name).psd1"

# Dot source the generator functions here

Export-ModuleMember -Function *-*