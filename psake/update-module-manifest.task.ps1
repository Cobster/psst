#
# UPDATE MODULE MANIFEST
# 
Task UpdateModuleManifest `
    -description "Updates the PowerShell module manifest file; sets the correct build number and updates other metadata." `
    -requiredVariables OutputDir, ReleaseNotes, Authors `
{
    if ([string]::IsNullOrEmpty($Version)) {
        $Version = "0.0.0.0"
    }
    
    $Author = [string]::Join(", ", $Authors)

    Write-Host "Setting version to $Version"
    Write-Host "Setting release notes uri to $ReleaseNotes"
    Write-Host "Setting author to $Author"
    Update-ModuleManifest -Path $OutputDir\$ModuleName.psd1 `
        -ModuleVersion $Version `
        -ReleaseNotes $ReleaseNotes `
        -Author $Author
}