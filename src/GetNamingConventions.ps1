<#

.SYNOPSIS
    Converts an upper camel case name (Pascal case) into a hash table of other naming conventions.

.PARAMETER Name
    The name of convert to other naming conventions.  This should be specified as upper camel case (Pascal case).

.PARAMETER PluralName
    This is an optional parameter that can be specified when pluralization of a name is something other than appending an 's'.

.EXAMPLE
    PS C:\> Get-NamingConventions -Name ItemList

    Name                           Value
    ----                           -----
    Name                           ItemList
    Plural                         {Name, UpperCamelCase, Uppercase, LowerCamelCase...}
    UpperCamelCase                 ItemList
    Uppercase                      ITEMLIST
    LowerCamelCase                 itemList
    KebabCase                      item-list
    Lowercase                      itemlist

.EXAMPLE
    Get the plural names

    PS C:\> $nc = Get-NamingConventions -Name ItemList
    PS C:\> $nc.Plural 

    Name                           Value
    ----                           -----
    Name                           ItemLists
    UpperCamelCase                 ItemLists
    Uppercase                      ITEMLISTS
    LowerCamelCase                 itemLists
    KebabCase                      item-lists
    Lowercase                      itemlists

#>

function Get-NamingConventions 
{
    param (
        [Parameter(Mandatory = $true)]
        [string] $Name,

        [string] $PluralName = "$($Name)s"
    )

    $Names = @{
        Name = $Name
        Lowercase = $Name.ToLower()
        Uppercase = $Name.ToUpper()
        UpperCamelCase = $Name
        LowerCamelCase = ([Char]::ToLower($Name[0]) + $Name.Substring(1))
        KebabCase = (ConvertTo-KebabCase -Name $Name)
        Plural = @{
            Name = $PluralName
            Lowercase = $PluralName.ToLower()
            Uppercase = $PluralName.ToUpper()
            UpperCamelCase = $PluralName
            LowerCamelCase = ([Char]::ToLower($PluralName[0]) + $PluralName.Substring(1))
            KebabCase = (ConvertTo-KebabCase -Name $PluralName)
        }
    }

    $Names
}