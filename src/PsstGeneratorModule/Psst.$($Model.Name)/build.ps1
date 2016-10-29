# Must import the psake powershell module

param (
    `$Version = "0.0.0",
    `$BuildNumber
)

# Get version from version file if not defined.

if (`$BuildNumber -ne `$null) {
    `$Version = "`$Version.`$BuildNumber"
}

Invoke-PSake Build -nologo -notr -parameters @{Version=`$Version}