<#

.SYNOPSIS
    Converts an upper camel case name (Pascal case) into a hash table of other naming conventions.

.PARAMETER Name
    The name of convert to other naming conventions.  This should be specified as upper camel case (Pascal case).

.PARAMETER PluralName
    This is an optional parameter that can be specified when pluralization of a name is something other than appending an 's'.

.EXAMPLE
    PS C:\> Get-NamingConventions -Name ItemList

    Name           : ItemList
    Lowercase      : itemlist
    Uppercase      : ITEMLIST
    UpperCamelCase : ItemList
    LowerCamelCase : itemList
    KebabCase      : item-list
    Plural         : @{Name=ItemLists; Lowercase=itemlists; Uppercase=ITEMLISTS; UpperCamelCase=ItemLists;
                    LowerCamelCase=itemLists; KebabCase=item-lists}

#>

function Get-NamingConventions 
{
    param (
        [Parameter(Mandatory = $true)]
        [string] $Name,

        [string] $PluralName = "$($Name)s"
    )

    $Obj = New-Object PSObject
    $Obj | Add-Member -MemberType NoteProperty -Name "Name" -Value $Name
    $Obj | Add-Member -MemberType NoteProperty -Name "Lowercase" -Value $Name.ToLower()
    $Obj | Add-Member -MemberType NoteProperty -Name "Uppercase" -Value $Name.ToUpper()
    $Obj | Add-Member -MemberType NoteProperty -Name "UpperCamelCase" -Value $Name
    $Obj | Add-Member -MemberType NoteProperty -Name "LowerCamelCase" -Value ([Char]::ToLower($Name[0]) + $Name.Substring(1))
    $Obj | Add-Member -MemberType NoteProperty -Name "KebabCase" -Value (ConvertTo-KebabCase -Name $Name)
    $Obj | Add-Member -MemberType NoteProperty -Name "Plural" -Value (New-Object PSObject)
    $Obj.Plural | Add-Member -MemberType NoteProperty -Name "Name" -Value $PluralName
    $Obj.Plural | Add-Member -MemberType NoteProperty -Name "Lowercase" -Value $PluralName.ToLower()
    $Obj.Plural | Add-Member -MemberType NoteProperty -Name "Uppercase" -Value $PluralName.ToUpper()
    $Obj.Plural | Add-Member -MemberType NoteProperty -Name "UpperCamelCase" -Value $PluralName
    $Obj.Plural | Add-Member -MemberType NoteProperty -Name "LowerCamelCase" -Value ([Char]::ToLower($PluralName[0]) + $PluralName.Substring(1))
    $Obj.Plural | Add-Member -MemberType NoteProperty -Name "KebabCase" -Value (ConvertTo-KebabCase -Name $PluralName)

    $Obj | Add-Member -MemberType ScriptMethod -Name "ToString" { $this.Name } -Force
    $Obj.Plural | Add-Member -MemberType ScriptMethod -Name "ToString" { $this.Name } -Force

    $Obj
}