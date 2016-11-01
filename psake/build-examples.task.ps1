Task BuildExamples `
    -requiredVariables ExamplesDir, ModuleName, ReleaseDir `
    -precondition { BuildOutputExists -and ModuleIsImported } `
{
    Write-Host "Creating new Psst.Azure module"
    New-PsstGeneratorModule -Name Azure -OutputPath $ExamplesDir
}