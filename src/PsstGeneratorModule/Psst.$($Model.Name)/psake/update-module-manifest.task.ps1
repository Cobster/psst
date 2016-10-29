#
# UPDATE MODULE MANIFEST
# 
Task UpdateModuleManifest ``
    -description "Updates the module manifest file; sets the correct build number and updates other metadata." ``
    -requiredVariables OutputDir, ReleaseNotes, Version ``
{
    Write-Verbose "Setting version to `$Version"
    Update-ModuleManifest -Path `$OutputDir\`$ModuleName.psd1 ``
        -ModuleVersion `$Version ``
        -ReleaseNotes `$ReleaseNotes ``
        -Author ([string]::Join(", ", `$Authors))
}
