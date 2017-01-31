#
# CLEAN
#
Task 'clean' `
    -description "Deletes the contents of the release directory and template cache." `
    -requiredVariables ReleaseDir, TemplateCache `
    -postcondition { ReleaseDirIsEmpty -and TemplateCacheDirIsDeleted } `
{
    if (Test-Path $ReleaseDir) { 
        Get-ChildItem $ReleaseDir | ForEach-Object {
            Write-Host "Removing: $($_.FullName)"
            Remove-Item -Path $_.FullName -Recurse -Force -Verbose:$VerbosePreference
        }
    }
    
    if (Get-Module -Name $ModuleName) {
        Write-Host "Removing module: $ModuleName"
        Remove-Module Psst    
    }

    if (Test-Path $TemplateCache) {
        Write-Host "Removing template cache: $TemplateCache"
        Remove-Item $TemplateCache -Force -Recurse
    }
}