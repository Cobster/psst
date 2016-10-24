# [0.2.1](https://github.com/cobster/psst/compare/0.2.1...0.2.0.0) (2016-10-24)

### Bug Fixes

* Fixes comparison link for differencing 0.1.0 to 0.2.0
* Fixes template expansion in versioned directory within local application data 
* Fixes `Install` and `Uninstall` build tasks to properly install into local users powershell module path.

### Features

* Outputs test results to 'PesterTestResults' 

# [0.2.0](https://github.com/cobster/psst/compare/0.1.0...0.2.0.0) (2016-10-24)

### Bug Fixes

* Parameterized template file names where uri encoded by nuget.
* Expands template files into local application data.

### Features

* Adds publishing build task
* Adds versioning to build

### Notes

* PowerShell 5.0.010586.117 contains a bug that causes the SetVersion build task to overwrite the FunctionsToExport as a space delimited string. Upgrade to 5.1.14394.1000.

# [0.1.0]() (2016-10-23)

### Features

* Adds `Expand-Template` which allows for the expansion of a powershell string with dynamic parameters.
* Adds `Expand-TemplateDirectory` which allows for the recursive expansion of a directory and all of its contents.
* Adds `New-PsstGenerator` which scaffolds the files needed to create a new Psst template generator.
* Adds `New-PsstGeneratorModule` which scaffolds the files needed to create a new Psst template module.
* Adds `Get-NamingConventions` which is a utility function that builds multiple versions of a name using common programming styles.
