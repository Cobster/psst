Task 'build-examples' `
    -requiredVariables ExamplesDir, ModuleName, ReleaseDir, Version `
    -precondition { BuildOutputExists -and ModuleIsImported } `
{
    Write-Host "Creating new Psst.Example module"
    New-PsstGeneratorModule -Name "Example" -OutputPath $ExamplesDir -Version $Version
}