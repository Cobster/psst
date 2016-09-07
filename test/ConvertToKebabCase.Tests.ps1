$src = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace '\\test', '\\src' 
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$src\$sut"

Describe "ConvertTo-KebabCase" {

    It "Converts to kebab casing" {
		ConvertTo-KebabCase ItemList | Should Be "item-list"
	}
	
    It "Converts the first character to lowercase" {
		$Kebab = ConvertTo-KebabCase ItemList 
		$Kebab[0] | Should Be i
    }

	It "Leaves the first character if already lowercase" {
		$Kebab = ConvertTo-KebabCase itemList
		$Kebab | Should Be "item-list"
	}

	It "Inserts a dash before a capital letter" {
		$Kebab = ConvertTo-KebabCase ItemList
		$Kebab[4] | Should Be '-'
	}

	It "Converts the first character after a dash to lowercase" {
		$Kebab = ConvertTo-KebabCase ItemList
		$Kebab[5] | Should Be 'l'
	}
}