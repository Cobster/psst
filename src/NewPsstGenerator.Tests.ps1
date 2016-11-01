$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Import-Module $here\Psst.psd1

Describe "New-PsstGenerator" {

    BeforeAll {
        $TestDirectory = [IO.Path]::Combine([IO.Path]::GetTempPath(), [IO.Path]::GetRandomFileName())
    }
    
    BeforeEach {
        New-Item $TestDirectory -ItemType Directory
        Push-Location $TestDirectory
    }

    AfterEach {
        Pop-Location
        Remove-Item $TestDirectory -Force -Recurse
    }

    It "Should create a script for the generator" {
        New-PsstGenerator -Name AngularApplication
        "$TestDirectory\NewAngularApplication.ps1" | Should Exist
    }

    It "Should create a directory for the generator template" {
        New-PsstGenerator -Name AngularApplication
        "$TestDirectory\AngularApplication" | Should Exist
    }

    It "Should not create a '.exclude' file in the template directory" {
        New-PsstGenerator -Name AngularApplication -Verbose
        "$TestDirectory\AngularApplication\.exclude" | Should Not Exist
    }

    It "Should create a 'New' function for the generator" {
        New-PsstGenerator -Name AngularApplication
        "$TestDirectory\NewAngularApplication.ps1" | Should Contain "function New-AngularApplication"
    }

    It "Should create an inline documentation section" {
        New-PsstGenerator -Name AngularApplication
        "$TestDirectory\NewAngularApplication.ps1" | Should Contain ".SYNOPSIS"
        "$TestDirectory\NewAngularApplication.ps1" | Should Contain ".DESCRIPTION"
        "$TestDirectory\NewAngularApplication.ps1" | Should Contain ".PARAMETER OutputPath"
    }

    It "Should create a test file" {
        New-PsstGenerator -Name AngularApplication
        "$TestDirectory\NewAngularApplication.Tests.ps1" | Should Exist
    }

}