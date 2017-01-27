# Psst - PowerShell Scaffolding Tool

Psst is a template-based file generator written in PowerShell.  Its purpose is to quickly 
create files from templates for any development language.  Generated files are created 
using predefined templates that use PowerShell's string replacement/interpolation syntax.

Installing Psst is a piece of cake.  Open PowerShell as an administrator and 
run the following command to download and install Psst.

```
PS> Install-Module Psst
```

Now that it is installed, Psst provides a few useful functions that will jump start your
the creation of new modules and templates.

```
PS> New-PsstGeneratorModule -Name Example
```

The preceding line of code creates a new folder named `Psst.Example` in your current directory. 
Inside the folder it will contain a new PowerShell module project that is setup to house new template generators.
It also scaffolds out a continuous delivery pipeline using [Psake](https://github.com/psake/psake) 
which makes it trivial to build, test, and deploy moments after creating the project.  For more
details on the build system, read about [continuous delivery](wiki/Continuous-Delivery) in the wiki. 

Run the following lines to build the project.

```
PS> cd Psst.Example
PS> .\build
```

Now you'll have a `bin/release` directory with the newly minted PowerShell module, the test results, 
and versioned zip file that contains the PowerShell module.

Next thing to do is to publish this to the [PowerShell Gallery](https://www.powershellgallery.com/). If 
you don't have an account, you can [register here](https://www.powershellgallery.com/users/account/LogOn?returnUrl=%2F). 
Then simply execute the following snippet. The first time running you'll be prompted for your PowerShell
Gallery API key which can be found on the [account page](https://www.powershellgallery.com/account).

```
PS> Invoke-psake publish
```

**Great!!!** You have successfully built and deployed your first Psst module.  It doesn't do much
but you can download and install your new module just as easily as it was to install `Psst`.

```
PS> Install-Module Psst.Example
```

...okay, so how do I actually use this?

```
New-PsstGenerator -Name Feature 
```

## Maintainers

- [Jacob Bruun](https://github.com/cobster)

## License

This project is [licensed under the MIT License](LICENSE)
