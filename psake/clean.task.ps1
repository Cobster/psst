#
# CLEAN
#
Task Clean `
    -description "Deletes the contents of the release directory and template cache." `
    -requiredVariables ReleaseDir, TemplateCache `
    -postcondition { ReleaseDirIsEmpty -and TemplateCacheDirIsDeleted } `
{
    if (Test-Path $ReleaseDir) { 
        Get-ChildItem $ReleaseDir | Remove-Item -Recurse -Force -Verbose:$VerbosePreference
    }
    if (Test-Path $TemplateCache) {
        Write-Host "Deleting template cache at $TemplateCache"
        Remove-Item $TemplateCache -Force -Recurse
    }
}