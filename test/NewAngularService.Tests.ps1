$src = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace '\\test', '\\src' 
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$src\$sut"


Describe "New-AngularService" {
    $TestDirectory = "TestDrive:\Test"

    BeforeEach {
        New-Item $TestDirectory -ItemType Directory
        Push-Location $TestDirectory
    }

    AfterEach {
        Pop-Location
        Remove-Item $TestDirectory -Force -Recurse
    }

    It "Should create a new service file" {
        New-AngularService -Name Item
        "$TestDirectory\item.service.ts" | Should Exist
    }

    It "Should create a new service test file" {
        New-AngularService -Name Item
        "$TestDirectory\item.service.spec.ts" | Should Exist
    }
}