$src = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace '\\test', '\\src' 
Import-Module $src\Psst.psd1

Describe "New-PsstGenerator" {
    $TestDirectory = [IO.Path]::Combine([IO.Path]::GetTempPath(), [IO.Path]::GetRandomFileName())

    BeforeEach {
        New-Item $TestDirectory -ItemType Directory
        Push-Location $TestDirectory
    }

    AfterEach {
        Pop-Location
        Remove-Item $TestDirectory -Force -Recurse
    }

    It "Should create 'New-' script file for the generator" {
        New-PsstGenerator -Name AngularApplication -Verbose
        "$TestDirectory\NewAngularApplication.ps1" | Should Exist
    }

}