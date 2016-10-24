<#

.SYNOPSIS

This function converts the provided Pascal cased name to its kebab case equivalent. (e.g. ItemList is converted to item-list)

#>
function ConvertTo-KebabCase {
	param (
		[string]$Name
	)

	if ($Name -eq $null) {
		return $null
	}

	$parts = @()
	$part = ""
	for ($i = 0; $i -lt $Name.Length; $i++) {
		if ([char]::IsUpper($Name[$i]) -and $part.Length -gt 0) {
			$parts += $part.ToLower()
			$part = ""
		} 

		$part += $Name[$i]
	}
	if ($part.Length) {
		$parts += $part.ToLower();
	}

	[string]::Join("-", $parts);
}