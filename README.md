# Psst - PowerShell Scaffolding Tool

Psst is a template-based file generator written in PowerShell.  Its purpose is to quickly 
create files from templates for any development language.  Generated files are created 
using predefined templates that use PowerShell's string replacement/interpolation syntax.

Installing Psst is a piece of cake.  Open PowerShell as an administrator and 
run the following command to download and install Psst.

```
PS> Install-Module Psst
```

Psst provides two useful functions that will jump start your ability to create your own
modules and templates.

```
New-PsstGeneratorModule -Name Angular2
```
Will create the folder `Psst.Angular2`, inside a new PowerShell module project that is
setup to house new template generators. For more information see the [wiki]().

```
New-PsstGenerator -Name Feature 
```

## Maintainers

- [Jacob Bruun](https://github.com/cobster)

## License

This project is [licensed under the MIT License](LICENSE)
