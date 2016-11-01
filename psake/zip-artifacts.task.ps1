#
# Zip Artifacts
#
Task ZipArtifacts `
    -description "This compresses the release module into a zip file for archival." `
    -requiredVariables OutputDir, Version `
    -precondition { BuildOutputExists } `
{
    #Write-Verbose "Compressing $ZipArtifactsOptions.InputPath $($ZipArtifactsOptions.OutputFileFormats)"

    $ZipArtifactsOptions.InputFilePath | Compress-Archive -DestinationPath "$($ZipArtifactsOptions.OutputFilePath)\$($ZipArtifactsOptions.OutputFileFormat)" -Verbose:$VerbosePreference -Update
    
}