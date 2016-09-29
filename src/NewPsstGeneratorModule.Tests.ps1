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

    It "Should be listed in the module data FunctionsToExport property" {
        $ModulePath = Get-ChildItem "$here\*.psd1" | Select-Object -First 1
        $ModuleData = Import-PowerShellDataFile -Path $ModulePath.FullName
        $ModuleData.FunctionsToExport -contains 'New-PsstGeneratorModule' | Should Be True
    }

    It "Should be dot sourced in the module file" {
        $ModulePath = Get-ChildItem "$here\*.psm1" | Select-Object -First 1
        "$($ModulePath.FullName)" | Should Contain "\. \`$PSScriptRoot\\NewPsstGeneratorModule\.ps1"
    }

    It "Should create a new folder prefixed with 'Psst.'" {
        New-PsstGeneratorModule -Name "Example"
        "$TestDirectory\Psst.Example" | Should Exist
    }

    It "Should create a new module data file" {
        new-PsstGeneratorModule -Name "Example"
        "$TestDirectory\Psst.Example\src\Psst.Example.psd1" | Should Exist
    }

    It "Should set the module script as the Root Module" {
        New-PsstGeneratorModule -name "Example"
        $ModuleData = Import-PowerShellDataFile -Path "$TestDirectory\Psst.Example\src\Psst.Example.psd1"
        $ModuleData.RootModule | Should BeExactly "Psst.Example.psm1"
    }

    It "Should set the Psst module as a required module" {
        New-PsstGeneratorModule -name "Example"
        $ModuleData = Import-PowerShellDataFile -Path "$TestDirectory\Psst.Example\src\Psst.Example.psd1"
        $ModuleData.RequiredModules[0] -contains 'Psst' | Should Be $true 
    }

    It "Should set the ModuleVersion to 1.0.0 by default" {
        New-PsstGeneratorModule -name "Example"
        $ModuleData = Import-PowerShellDataFile -Path "$TestDirectory\Psst.Example\src\Psst.Example.psd1"
        $ModuleData.ModuleVersion | Should Be '1.0.0'
    }

    It "Should set the ModuleVersion to the version specified at the command line" {
        New-PsstGeneratorModule -Name "Example" -Version '1.1.0'
        $ModuleData = Import-PowerShellDataFile -Path "$TestDirectory\Psst.Example\src\Psst.Example.psd1"
        $ModuleData.ModuleVersion | Should Be '1.1.0'
    }

    It "Should create a new module file" {
        New-PsstGeneratorModule -Name "Example"
        "$TestDirectory\Psst.Example\src\Psst.Example.psm1" | Should Exist
    }

    It "Should define the `$ModuleData parameter in the module" {
        New-PsstGeneratorModule -name "Example"
        "$TestDirectory\Psst.Example\src\Psst.Example.psm1" | Should Contain "\`$ModuleData = Import\-PowerShellDataFile \`"\`$PSScriptRoot\\Psst\.Example\.psd1\`""
    }

    It "Should create a new LICENSE file" {
        New-PsstGeneratorModule -name "Example"
        "$TestDirectory\Psst.Example\LICENSE" | Should Exist
    }

    It "Should create a 'README.md' file" {
        New-PsstGeneratorModule -Name "Example"
        "$TestDirectory\Psst.Example\README.md" | Should Exist
    }

    It "Should create a 'test.ps1' script file" {
        New-PsstGeneratorModule -Name "Example"
        "$TestDirectory\Psst.Example\test.ps1" | Should Exist
    }

}
