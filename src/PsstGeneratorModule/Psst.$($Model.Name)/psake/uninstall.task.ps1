#
# UNINSTALL
#
Task 'uninstall' ``
    -description "Removes the module from the current users PowerShell module path." ``
    -requiredVariables ModuleName, OutputDir ``
    -precondition { BuildOutputExists } ``
{
    `$UserModulePath = "`$HOME\Documents\WindowsPowerShell\Modules\`$ModuleName"
    if (Test-Path `$UserModulePath) {
        Write-Host "Removing `$UserModulePath"
        Remove-Item `$UserModulePath -Force -Recurse
    }
}