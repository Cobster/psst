# Must import the psake powershell module

param (
    $BaseVersion,
    $BuildNumber = 0
)

Invoke-PSake Build -nologo -notr -parameters @{BaseVersion=$BaseVersion;BuildNumber=$BuildNumber}