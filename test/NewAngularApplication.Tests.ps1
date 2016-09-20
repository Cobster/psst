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
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\tsconfig.json" | Should Exist;
    }

    It "Should create a typings configuration file" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\typings.json" | Should Exist;
    }

    It "Should create a npm configuration file" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\package.json" | Should Exist;
    }

    It "Should set the name of the application in the npm configuration" {
        New-AngularApplication -Name "MyTest"
        $Package = Get-Content "$TestDirectory\package.json" | ConvertFrom-Json
        $Package.Name | Should BeExactly "my-test"
    }

    It "Should create karma test configuration file" {
        New-AngularApplication -Name "MyTest" 
        "$TestDirectory\karma.conf.js" | Should Exist
    }

    It "Should create a karma test shim file" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\karma-test-shim.js" | Should Exist
    }

    It "Should create a webpack configuration file" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\webpack.config.js" | Should Exist
    }

    It "Should create a webpack test configuration file" {
        New-AngularApplication -Name "MyTest" 
        "$TestDirectory\webpack.test.js" | Should Exist
    }

    It "Should create a webpack helpers file" {
        New-AngularApplication -Name "MyTest" 
        "$TestDirectory\webpack.helpers.js" | Should Exist
    }

    It "Should create a readme markdown file" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\README.md" | Should Exist
    }

    It "Should create a folder named 'client'" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\Client" | Should Exist
    }

    It "Should create a 'vendor.ts' file in the 'client' folder" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\Client\vendor.ts" | Should Exist
    }

    It "Should create a 'polyfills.ts' file in the 'client' folder" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\Client\polyfills.ts" | Should Exist
    }

    It "Should create a 'main.ts' file in the 'client' folder" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\Client\main.ts" | Should Exist
    }

    It "Should create an 'index.html' file in the 'client' folder" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\Client\index.html" | Should Exist
    }

    It "Should generate an application specific element in the 'index.html' file" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\Client\index.html" | Should Contain "\<my\-test\-app\>Loading\.\.\.\<\/my\-test\-app\>"
    }

    It "Should generate a 'styles.scss' file when -Styles is set to 'sass'" {
        New-AngularApplication -Name "MyTest" -Styles Sass
        "$TestDirectory\Client\styles.scss" | Should Exist
    }

    It "Should generate a 'styles.css' file when -Styles is set to 'css'" {
        New-AngularApplication -Name "MyTest" -Styles Css
        "$TestDirectory\Client\styles.css" | Should Exist
    }

    It "Should generate a 'styles.less' file when -Styles is set to 'less'" {
        New-AngularApplication -Name "MyTest" -Styles Less
        "$TestDirectory\Client\styles.less" | Should Exist
    }

    It "Should generate an 'app' root module" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\Client\app\app.module.ts" | Should Exist
    }

    It "Should generate an 'AppModule' class" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\Client\app\app.module.ts" | Should Contain "export class AppModule"
    }

    It "Should generate an 'app.component'" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\Client\app\app.component.ts" | Should Exist
    }

    It "Should generate an 'AppComponent' class" {
        New-AngularApplication -Name "MyTest" 
        "$TestDirectory\Client\app\app.component.ts" | Should Contain "export class AppComponent"
    }

    It "Should generate an application specific selector" {
        New-AngularApplication -Name "MyTest" 
        "$TestDirectory\Client\app\app.component.ts" | Should Contain "selector\: 'my\-test\-app'"
    }

    It "Should generate an app routing module" {
        New-AngularApplication -Name "MyTest"
        "$TestDirectory\Client\app\app.routing.ts" | Should Exist
    }
}