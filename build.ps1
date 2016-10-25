# Must import the psake powershell module

param (
    $Version = (Get-Content $PSScriptRoot\version),
    $BuildNumber
)

# Get version from version file if not defined.
if ([string]::IsNullOrWhitespace($Version)) {
    $Version = Get-Content $PSScriptRoot\version
}

if ($BuildNumber -ne $null) {
    $Version = "$Version.$BuildNumber"
}

Invoke-PSake Build -nologo -notr -parameters @{Version=$Version}