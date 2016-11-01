. $PSScriptRoot\conditions.ps1
. $PSScriptRoot\settings.ps1

# dot source all the tasks within this directory
Get-ChildItem $PSScriptRoot -Filter *.task.ps1 -Recurse | ForEach-Object { . $_.FullName }