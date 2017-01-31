# [0.2.3](https://github.com/cobster/psst/compare/0.2.2...0.2.3) (2017-01-30)

### Features

* Adds -TemplatePath to New-PsstGenerator which recursively copies all the files into the generators template directory.

### Bug Fixes 
* Files marked for exclusion are no longer generated during expansion.
* Expands templates correctly when given a relative output path.

# [0.2.2](https://github.com/cobster/psst/compare/0.2.1...0.2.2) (2016-10-24)

### Features

* Adds build script. Can set the version, or a build number.
* Clean task clears the local application data template cache for the current version.
* Exposes `Authors` as a configurable setting. 
* Adds `.gitignore` file to the psst module template.

### Bug Fixes

* Fixes execution problems in psake tasks due to invalid template generation.
* Pester test results are output to release directory.

### Code Refactoring

* Makes the `Name` parameter first on `New-PsstGeneratorModule`
* Had to remove the dependency on the `Psst` module from the module templates. 

# [0.2.1](https://github.com/cobster/psst/compare/0.2.0.0...0.2.1) (2016-10-24)

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
