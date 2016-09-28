Remove-Module Psst.$($Model.Name) -ErrorAction SilentlyContinue
Import-Module `$PSScriptRoot\src\Psst.$($Model.Name).psd1
Invoke-Pester `$PSScriptRoot