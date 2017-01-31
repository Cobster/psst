#
# CLEAN
#
Task 'clean' ``
    -description "Deletes the contents of the release directory." ``
    -requiredVariables ModuleName, ReleaseDir, TemplateCache ``
{
    if (Test-Path `$ReleaseDir) {
        Get-ChildItem `$ReleaseDir | ForEach-Object {
            Write-Host "Removing `$(`$_.FullName)"
            Remove-Item -Path `$_.FullName -Recurse -Force -Verbose:`$VerbosePreference
        }
    }

    if (Get-Module -Name `$ModuleName) {
        Write-Host "Removing module: `$ModuleName"
        Remove-Module `$ModuleName
    }

    if ((Test-Path `$TemplateCache)) {
        Write-Host "Deleting template cache at `$TemplateCache"
        Remove-Item `$TemplateCache -Force -Recurse
    }
}