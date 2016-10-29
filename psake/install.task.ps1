#
# INSTALL
# 
Task Install `
    -description "Copies the release module into the current users PowerShell module path." `
    -requiredVariables ModuleName, OutputDir `
    -precondition { BuildOutputExists } `
{
    $UserModulePath = "$HOME\Documents\WindowsPowerShell\Modules\$ModuleName"
    if (Test-Path $UserModulePath) {
        Write-Host "Removing $UserModulePath"
        Remove-Item $UserModulePath -Force -Recurse
    }

    Write-Host "Copying $OutputDir to $UserModulePath"    
    Copy-Item $OutputDir -Destination $UserModulePath  -Recurse
}