#
# Zip Artifacts
#
Task 'zip-artifacts' `
    -description "This compresses the release module into a zip file for archival." `
    -requiredVariables OutputDir, Version `
    -precondition { BuildOutputExists } `
{
    $ZipArtifactsOptions.InputFilePath | Compress-Archive -DestinationPath "$($ZipArtifactsOptions.OutputFilePath)\$($ZipArtifactsOptions.OutputFileFormat)" -Verbose:$VerbosePreference -Update
}