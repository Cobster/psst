$src = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace '\\test', '\\src' 
Import-Module $src\Psst.psd1

Describe "New-AngularApplication" {
    $TestDirectory = "TestDrive:\Test"

    BeforeEach {
        New-Item $TestDirectory -ItemType Directory
        Push-Location $TestDirectory
    }

    AfterEach {
        Pop-Location
        Remove-Item $TestDirectory -Force -Recurse
    }

    It "Should create a typescript configuration file" {
        New-AngularApplication -Name "Test"
        "$TestDirectory\tsconfig.json" | Should Exist;
    }

    It "Should create a typings configuration file" {
        New-AngularApplication -Name "Test"
        "$TestDirectory\typings.json" | Should Exist;
    }

    It "Should create a npm configuration file" {
        New-AngularApplication -Name "Test"
        "$TestDirectory\package.json" | Should Exist;
    }

    It "Should set the name of the application in the npm configuration" {
        New-AngularApplication -Name "Test"
        $Package = Get-Content "$TestDirectory\package.json" | ConvertFrom-Json
        $Package.Name | Should BeExactly "test"
    }

    It "Should create karma test configuration file" {
        New-AngularApplication -Name "Test" 
        "$TestDirectory\karma.conf.js" | Should Exist
    }

    It "Should create a karma test shim file" {
        New-AngularApplication -Name "Test"
        "$TestDirectory\karma-test-shim.js" | Should Exist
    }

    It "Should create a webpack configuration file" {
        New-AngularApplication -Name "Test"
        "$TestDirectory\webpack.config.js" | Should Exist
    }

    It "Should create a webpack test configuration file" {
        New-AngularApplication -Name "Test" 
        "$TestDirectory\webpack.test.js" | Should Exist
    }

    It "Should create a webpack helpers file" {
        New-AngularApplication -Name "Test" 
        "$TestDirectory\webpack.helpers.js" | Should Exist
    }

    It "Should create a readme markdown file" {
        New-AngularApplication -Name "Test"
        "$TestDirectory\README.md" | Should Exist
    }
}