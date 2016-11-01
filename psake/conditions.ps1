function BuildOutputExists 
{ 
    Test-Path $OutputDir 
}

function ReleaseDirIsEmpty
{
    (Get-ChildItem $ReleaseDir | Measure-Object).Count -eq 0
}

function TemplateCacheDirIsDeleted 
{
    -not (Test-Path $TemplateCache)
}

function ModuleIsImported 
{
    Get-Module $ModuleName -ne $null
}