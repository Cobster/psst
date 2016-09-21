$src = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace '\\test', '\\src' 
Import-Module $src\Psst.psd1

Describe "New-AspNetCoreWebApi" {
    $TestDirectory = "TestDrive:\Test"

    BeforeEach {
        New-Item $TestDirectory -ItemType Directory
        Push-Location $TestDirectory
    }

    AfterEach {
        Pop-Location
        Remove-Item $TestDirectory -Force -Recurse
    }

    It "Should create new folder for the ASP.Net Core project" {
        New-AspNetCoreWebApi -Name MyApi
        "$TestDirectory\MyApi.WebApi" | Should Exist;
    }

    It "Should create a 'web.config' file inside the project folder" {
        New-AspNetCoreWebApi -Name MyApi
        "$TestDirectory\MyApi.WebApi\web.config" | Should Exist;
    }

}