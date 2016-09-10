$src = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace '\\test', '\\src' 
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$src\$sut"

. "$src\ConvertToKebabCase.ps1"

Describe "Get-NamingConventions" {

    It "Should default to the name" {
        (Get-NamingConventions -Name "ItemList").ToString() | Should Be "ItemList"
    }

    It "Should return the lowercase name" {
        (Get-NamingConventions -Name "ItemList").Lowercase | Should Be "itemlist"
    }

    It "Should return the uppercase name" {
        (Get-NamingConventions -Name "ItemList").Uppercase | Should Be "ITEMLIST"
    }

    It "Should return the upper camel case name" {
        (Get-NamingConventions -Name "ItemList").UpperCamelCase | Should Be "ItemList"
    }

    It "Should return the lower camel case name" {
        (Get-NamingConventions -Name "ItemList").LowerCamelCase | Should Be "itemList"
    }

    It "Should return the kebab case name" {
        (Get-NamingConventions -Name "ItemList").KebabCase | Should Be "item-list"
    }

    It "Should append an 's' for the default plural name" {
        (Get-NamingConventions -Name "Goose").Plural.Name | Should Be "Gooses"
    }

    It "Should be able to specify a custom plural name" {
        (Get-NamingConventions -Name "Goose" -Plural "Geese").Plural.Name | Should Be "Geese"
    }

    It "Should using upper camel case for ToString" {
        (Get-NamingConventions -Name "ItemList").Plural.ToString() | Should Be "ItemLists"
    }

    It "Should return the plural lowercase name" {
        (Get-NamingConventions -Name "ItemList").Plural.Lowercase | Should Be "itemlists"
    }

    It "Should return the plural uppercase name" {
        (Get-NamingConventions -Name "ItemList").Plural.Lowercase | Should Be "itemlists"
    }

    It "Should return the plural upper camel case name" {
        (Get-NamingConventions -Name "ItemList").Plural.UpperCamelCase | Should Be "ItemLists"
    }

    It "Should return the plural lower camel case name" {
        (Get-NamingConventions -Name "ItemList").Plural.LowerCamelCase | Should Be "itemLists"
    }

    It "Should return the plural kebab case name" {
        (Get-NamingConventions -Name "ItemList").Plural.KebabCase | Should Be "item-lists"
    }

    It "Should capitalize the first letter if it is lowercase" {
        (Get-NamingConventions -Name "itemList").Name | Should Be "ItemList"
    }
}