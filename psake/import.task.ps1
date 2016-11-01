Task Import `
    -description "Imports the module from the build output directory." `
    -precondition { BuildOutputExists } `
{
    Import-Module $OutputDir -Scope:Global
}