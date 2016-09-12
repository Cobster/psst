$src = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace '\\test', '\\src' 
Import-Module $src\Psst.psd1

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

    It "Should export the module from the bundle file" {
        New-AngularFeature -Name Items
        "$TestDirectory\items\index.ts" | Should Contain "export \* from \'\.\/items\.module\';"
    }

    It "Should create a new module file" {
        New-AngularFeature -Name Items
        "$TestDirectory\items\items.module.ts" | Should Exist
    }

    It "Should create a new routing module when -Routing is specified" {
        New-AngularFeature -Name Items -Routing
        "$TestDirectory\items\items.routing.ts" | Should Exist
    }

    It "Should export the routing module from the bundle when -Routing is specified" {
        New-AngularFeature -Name Items -Routing
        "$TestDirectory\items\index.ts" | Should Contain "export \* from \'\.\/items\.routing\';"
    }

    It "Should import the routing module when -Routing is specified" {
        New-AngularFeature -Name Items -Routing
        "$TestDirectory\items\items.module.ts" | Should Contain "import \{.*ItemsRouting.*\} from \'\.\/items\.routing\';"
    }

    It "Should import the routing module providers when -Routing is specified" {
        New-AngularFeature -Name Items -Routing
        "$TestDirectory\items\items.module.ts" | Should Contain "import \{.*ItemsRoutingProviders.*\} from \'\.\/items\.routing\';"
    }

    It "Should import the routing module into the feature module when -Routing is specified" {
        New-AngularFeature -Name Items -Routing
        $Module = Get-Content -Path "$TestDirectory\items\items.module.ts" -Raw 
        [Text.RegularExpressions.Regex]::IsMatch($Module, 'imports\: \[.*ItemsRouting.*\]', "Singleline") | Should Be True       
    }

    It "Should provide the routing module providers from the feature module when -Routing is specified" {
        New-AngularFeature -Name Items -Routing
        $Module = Get-Content -Path "$TestDirectory\items\items.module.ts" -Raw 
        [Text.RegularExpressions.Regex]::IsMatch($Module, 'providers\: \[.*ItemsRoutingProviders.*\]', "Singleline") | Should Be True
    }

    It "Should import the common module" {
        New-AngularFeature -Name Items -Routing
        "$TestDirectory\items\items.module.ts" | Should Contain "import \{ CommonModule \} from \'\@angular\/common\';"
    }

    It "Should import the common module into the feature module" {
        New-AngularFeature -Name Items -Routing
        $Module = Get-Content -Path "$TestDirectory\items\items.module.ts" -Raw 
        [Text.RegularExpressions.Regex]::IsMatch($Module, 'imports\: \[.*CommonModule.*\]', "Singleline") | Should Be True
    }
}