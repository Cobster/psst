. `$PSScriptRoot\conditions.ps1
. `$PSScriptRoot\settings.ps1

Get-ChildItem `$PSScriptRoot -Filter *.task.ps1 -Recurse | ForEach-Object { . `$_.FullName }