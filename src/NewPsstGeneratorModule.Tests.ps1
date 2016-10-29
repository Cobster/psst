$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "New-PsstGeneratorModule" {
    $TestDirectory = [IO.Path]::Combine([IO.Path]::GetTempPath(), [IO.Path]::GetRandomFileName())

    BeforeEach {
        New-Item $TestDirectory -ItemType Directory
        Push-Location $TestDirectory
    }

    AfterEach {
        Pop-Location
        Remove-Item $TestDirectory -Force -Recurse
    }

    It "Should be dot sourced in the module file" {
        $ModulePath = Get-ChildItem "$here\*.psm1" | Select-Object -First 1
        "$($ModulePath.FullName)" | Should Contain "\. \`$PSScriptRoot\\NewPsstGeneratorModule\.ps1"
    }

    It "Should set the module script as the Root Module" {
        New-PsstGeneratorModule -name "Example"
        $ModuleData = Import-PowerShellDataFile -Path "$TestDirectory\Psst.Example\src\Psst.Example.psd1"
        $ModuleData.RootModule | Should BeExactly "Psst.Example.psm1"
    }

    # It "Should set the Psst module as a required module" {
    #     New-PsstGeneratorModule -name "Example"
    #     $ModuleData = Import-PowerShellDataFile -Path "$TestDirectory\Psst.Example\src\Psst.Example.psd1"
    #     $ModuleData.RequiredModules -contains 'Psst' | Should Be $true 
    # }

    It "Should set the ModuleVersion to 0.0.0 by default" {
        New-PsstGeneratorModule -name "Example"
        $ModuleData = Import-PowerShellDataFile -Path "$TestDirectory\Psst.Example\src\Psst.Example.psd1"
        $ModuleData.ModuleVersion | Should Be '0.0.0'
    }

    It "Should set the ModuleVersion to the version specified at the command line" {
        New-PsstGeneratorModule -Name "Example" -Version '1.1.0'
        $ModuleData = Import-PowerShellDataFile -Path "$TestDirectory\Psst.Example\src\Psst.Example.psd1"
        $ModuleData.ModuleVersion | Should Be '1.1.0'
    }

    It "Should define the `$ModuleData parameter in the module" {
        New-PsstGeneratorModule -name "Example"
        "$TestDirectory\Psst.Example\src\Psst.Example.psm1" | Should Contain "\`$ModuleData = Import\-PowerShellDataFile \`"\`$PSScriptRoot\\Psst\.Example\.psd1\`""
    }

    It "Should create this directory structure" {
        New-PsstGeneratorModule -Name "Example"

        @(
            "$TestDirectory\Psst.Example\",
            "$TestDirectory\Psst.Example\.gitignore",
            "$TestDirectory\Psst.Example\build.ps1",
            "$TestDirectory\Psst.Example\default.ps1",
            "$TestDirectory\Psst.Example\LICENSE",
            "$TestDirectory\Psst.Example\README.md",
            "$TestDirectory\Psst.Example\psake\build-impl.task.ps1",
            "$TestDirectory\Psst.Example\psake\build.task.ps1",
            "$TestDirectory\Psst.Example\psake\clean.task.ps1",
            "$TestDirectory\Psst.Example\psake\compress-templates.task.ps1",
            "$TestDirectory\Psst.Example\psake\conditions.ps1",
            "$TestDirectory\Psst.Example\psake\default.task.ps1",
            "$TestDirectory\Psst.Example\psake\import.task.ps1",
            "$TestDirectory\Psst.Example\psake\init.task.ps1",
            "$TestDirectory\Psst.Example\psake\install.task.ps1",
            "$TestDirectory\Psst.Example\psake\publish.task.ps1",
            "$TestDirectory\Psst.Example\psake\settings.ps1",
            "$TestDirectory\Psst.Example\psake\tasks.ps1",
            "$TestDirectory\Psst.Example\psake\test.task.ps1",
            "$TestDirectory\Psst.Example\psake\uninstall.task.ps1",
            "$TestDirectory\Psst.Example\psake\update-module-manifest.task.ps1",
            "$TestDirectory\Psst.Example\psake\zip-artifacts.task.ps1",
            "$TestDirectory\Psst.Example\src\Psst.Example.psd1",
            "$TestDirectory\Psst.Example\src\Psst.Example.psm1"
        ) | Should Exist
    }
}