Remove-Module Psst -ErrorAction SilentlyContinue
Import-Module $PSScriptRoot\src\Psst.psd1
Invoke-Pester $PSScriptRoot