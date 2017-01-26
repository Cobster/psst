#
# This assumes the project has already been built.
#

<#
Import-Module $PSScriptRoot\release\Psst

if (Test-Path $pwd/Psst.Example) {
    Remove-Item $pwd/Psst.Example -Recurse -Force
}

New-PsstGeneratorModule -Name Example

pushd $pwd\Psst.Example

.\build -Version (Get-Content $PSScriptRoot\version)
#>

Describe "Psst End To End Tests" {

    BeforeAll {
        Remove-Module "Psst"

        Import-Module $PSScriptRoot\bin\release\Psst
        $TestDir = "$PSScriptRoot\e2e\"
        if (-not (Test-Path $TestDir)) {
            New-Item $TestDir -ItemType Directory | Out-Null
        }
        
        Get-ChildItem $TestDir | Remove-Item -Recurse -Force 

        # Create the "Example" module and move to its project directory
        New-PsstGeneratorModule -Name Example -Version "0.1.0"
        Set-Location "$pwd\Psst.Example"
    }

    BeforeEach {
        Push-Location $TestDir
    }

    AfterEach {
        Pop-Location
    }

    AfterAll {
        Remove-Module Psst
    }

    It "Should create psst modules that can be built" {

        Invoke-Psake -TaskList Build

        $psake.build_success | Should Be True

        #Invoke-Psake -TaskList Init

        

        "$pwd\bin\release\Psst.Example" | Should Exist
    }

    It "Should generate a new psst module that can be built" {

        


    }

}