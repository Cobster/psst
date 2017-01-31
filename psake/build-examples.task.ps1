Task 'build-examples' `
    -requiredVariables ExamplesDir, ModuleName, ReleaseDir, Version `
    -precondition { BuildOutputExists -and ModuleIsImported } `
{
    Write-Host "Creating new Psst.Azure module"
    Invoke-PsstGeneratorModule -Name "Example" -OutputPath $ExamplesDir -Version $Version
}