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
    
    Write-Verbose "Setting version to $Version"
    Update-ModuleManifest -Path $OutputDir\$ModuleName.psd1 `
        -ModuleVersion $Version `
        -ReleaseNotes $ReleaseNotes `
        -Author ([string]::Join(", ", $Authors))
}