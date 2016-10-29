# Must import the psake powershell module

param (
    $Version = "0.2.3",
    $BuildNumber
)

if ($BuildNumber -ne $null) {
    $Version = "$Version.$BuildNumber"
}

Invoke-PSake Build -nologo -notr -parameters @{Version=$Version}