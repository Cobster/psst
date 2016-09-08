$src = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace '\\test', '\\src' 
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$src\$sut"

. "$src\ExpandTemplate.ps1"
. "$src\ConvertToKebabCase.ps1"
. "$src\GetNamingConventions.ps1"

Describe "New-AngularComponent" {
    $TestDirectory = "TestDrive:\Test"

    BeforeEach {
        New-Item $TestDirectory -ItemType Directory
        Push-Location $TestDirectory
    }

    AfterEach {
        Pop-Location
        Remove-Item $TestDirectory -Force -Recurse
    }


    It "Should create a new typescript file for the component" {
        New-AngularComponent -Name ItemList
        ".\item-list.component.ts" | Should Exist
    }

    It "Should create a new html file for the component" {
        New-AngularComponent -Name ItemList
        ".\item-list.component.html" | Should Exist
    }

    It "Should create a new test file for the component" {
        New-AngularComponent -Name ItemList
        ".\item-list.component.spec.ts" | Should Exist
    }


    It "Should create a css file for the component when css is specified" {
        New-AngularComponent -Name ItemList -Styles Css
        ".\item-list.component.css" | Should Exist
    }

    It "Should not create a css file when -Styles is not specified" {
        New-AngularComponent -Name ItemList
        ".\item-list.component.css" | Should Not Exist
    }

    It "Should define the 'styles' component metadata when -Styles is Css" {
        New-AngularComponent -Name ItemList -Styles Css
        ".\item-list.component.ts" | Should Contain "styles\: \[require\('\./item\-list\.component\.css'\)\]"
    }

    It "Should not define the 'styles' component metadata when -Styles is not specified" {
        New-AngularComponent -Name ItemList 
        ".\item-list.component.ts" | Should Not Contain "styles\: \[require\('\./item\-list\.component\.css'\)\]"
    }

    It "Should create a sass file for the component when 'sass' is specified for -Styles" {
        New-AngularComponent -Name ItemList -Styles Sass
        ".\item-list.component.scss" | Should Exist
    }

    It "Should create a sass file for the component when 'scss' is specified for -Styles" {
        New-AngularComponent -Name ItemList -Styles Scss
        ".\item-list.component.scss" | Should Exist
    }

    It "Should define the 'styles' component metadata when -Styles is sass" {
        New-AngularComponent -Name ItemList -Styles Sass
        ".\item-list.component.ts" | Should Contain "styles\: \[require\('\./item\-list\.component\.scss'\)\]"
    }

    It "Should create a less file for the component when 'less' is specified for -Styles" {
        New-AngularComponent -Name ItemList -Styles Less
        ".\item-list.component.less" | Should Exist
    }

    It "Should define the 'styles' component metadata when -Styles is less" {
        New-AngularComponent -Name ItemList -Styles Less
        ".\item-list.component.ts" | Should Contain "styles\: \[require\('\./item\-list\.component\.less'\)\]"
    }

    # It "Should not define a selector when -NoSelector is specified" {
    #     New-AngularComponent -Name ItemList -Prefix "x" -NoSelector
    #     ".\item-list.component.ts" | Should Not Contain "selector\: 'x-item-list'"
    # }

    It "Should set the 'selector' metadata to the specified -Selector value" {
        New-AngularComponent -Name ItemList -Selector 'x-item-list'
        ".\item-list.component.ts" | Should Contain "selector\: 'x-item-list'"
    }

    It "Should not define 'selector' metadata when -Selector is not specified" {
        New-AngularComponent -Name ItemList
        ".\item-list.component.ts" | Should Not Contain "selector\: '[\w\-]*'"
    }
}