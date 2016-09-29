# Psst - PowerShell Scaffolding Tool

Psst is a template-based file generator written in PowerShell.  Its purpose is to quickly 
create files from templates for any development language.  Generated files are created 
using predefined templates that use PowerShell's string replacement/interpolation syntax.

Psst also comes with a predefined set of templates and functions that can simplify the 
creation of application building blocks.

The initial set of building blocks being developed are for Angular2.  The file templates 
generated are powershell equivalents to those created by the 
[angular-cli](https://github.com/angular/angular-cli) project. 


## How to create a Psst generator module

1. Create a new folder with the name of the generator.  Convention is to prefix the the folder with `Psst.` (eg `Psst.Angular2`).
1. Go to the newly created directory. (e.g. `cd Psst.Angular2`)
1. Create a new powershell module file. (e.g. `New-Item Psst.Angular2.psm1 -ItemType File`)
1. Create a new powershell module data file. (e.g. `New-ModuleManifest -Path Psst.Angular2.psd1`)
1. Open the powershell module data file.
1. Uncomment the `RootModule` property and set the value to the module file. (e.g. `RootModule = 'Psst.Angular2.psm1'`)
1. Uncomment and set the `RequiredModules` property to `Psst`. (e.g. `RequiredModules = @('Psst')`)
1. Uncomment and add `Psst` and `PsstGenerator` to the `PrivateData.PSData.Tags` property.  Additional tags can be provided to help classification. (e.g. `Tags = @('Psst','PsstGenerator','Angular2')`)   

## How to create a Psst generator

1. Run the `New-PsstGenerator` function to scaffold a new psst generator script. (e.g. `New-PsstGenerator -Name AngularApplication`)
2. Dot source the file in the PowerShell module file. (e.g. `. $PSScriptRoot\NewAngularApplication.ps1`)
3. Expose the generator function in the PowerShell module data file by adding it to the `FunctionsToExport` property. (e.g. `FunctionsToExport = @('New-AngularApplication'`)`)

## Angular 2 scaffolding functions

#### New-AngularApplication

#### New-AngularComponent

#### New-AngularFeature

#### New-AngularService

## Maintainers

- [Jacob Bruun](https://github.com/cobster) - [Automate all the things](http://jacobbruun.com)

## License

This project is [licensed under the MIT License](LICENSE)
