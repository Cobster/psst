$src = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace '\\test', '\\src' 
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$src\$sut"

Describe "New-AngularFeature" {
    $TestDirectory = "TestDrive:\Test"

    BeforeEach {
        New-Item $TestDirectory -ItemType Directory
        Push-Location $TestDirectory
    }

    AfterEach {
        Pop-Location
        Remove-Item $TestDirectory -Force -Recurse
    }


    It "Should create a new folder to store the feature" {
        New-AngularFeature -Name Items
        "$TestDirectory\items" | Should Exist
    }

    It "Should create a new bundle file as 'index.ts'" {
        New-AngularFeature -Name Items
        "$TestDirectory\items\index.ts" | Should Exist
    }

    It "Should create a new module file" {
        New-AngularFeature -Name Items
        "$TestDirectory\items\items.module.ts" | Should Exist
    }

    It "Should create a new routing module when '-Routing' is specified" {
        New-AngularFeature -Name Items -Routing
        "$TestDirectory\items\items.routing.ts" | Should Exist
    }
}