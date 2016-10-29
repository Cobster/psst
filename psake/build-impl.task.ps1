#
# BUILD
#
Task BuildImpl `
    -description "This copies all the powershell code and scaffolding templates to the `$OutputDir." `
    -requiredVariables OutputDir, SrcDir, Exclude `
{
    # Copy all the scripts into the release directory
    Copy-Item -Path $SrcDir -Destination $OutputDir -Recurse -Exclude $Exclude -Verbose:$VerbosePreference
}
