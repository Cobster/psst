# 
# COMPRESS TEMPLATES
#
# This task should be run prior to publishing the project as a nuget package. In addition to 
# lowering the file size, this is specifically used to prevent a bug that is caused by URI
# encoding of the file names during publishing.
#
# If you have a templatized file name .ts it will be encoded to %24(%24Model.Name.KebabCase).ts  
Task 'compress-templates' `
    -description "This compresses each of the templates in the build output into a zip archive and removes." `
    -requiredVariables OutputDir `
    -precondition { Test-Path $OutputDir } `
{
    Get-ChildItem $OutputDir -Directory | ForEach-Object {
        Compress-Archive $_.FullName -DestinationPath "$($_.FullName).zip" -Force
        Remove-Item $_.FullName -Force -Recurse
    }
}