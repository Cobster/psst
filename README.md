# Psst - PowerShell Scaffolding Tool

Psst is a template-based file generator written in PowerShell.  Its purpose is to create files from 
predefined templates.  This is useful for scaffolding new projects or components within development projects.

Generated files are created using predefined templates that use PowerShell's string replacement/interpolation syntax.

Installing Psst is a piece of cake.  Open PowerShell as an administrator and run the following command to download and install Psst.

```
PS> Install-Module Psst
```

Now that it is installed, Psst provides a few useful functions that will jump start your the creation of new modules and templates.

```
PS> New-PsstGeneratorModule -Name Example -Version "1.0.0"
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

So how do I actually use this?

```
PS> New-PsstGenerator -Name Feature -OutputPath ./src
```

Which will create the following in the `src` folder.

```
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        1/30/2017   9:32 PM                Feature
-a----        1/30/2017   9:32 PM           1111 NewFeature.ps1
-a----        1/30/2017   9:32 PM           1052 NewFeature.Tests.ps1
```

The contents of the `Feature` directory are empty, but will be the home for all the templated files which make up the feature.  
The `New-Feature.ps1` contains the following code. The main part to notice is the definition of the `$Model` variable. This is
just a PowerShell hash table which can be modified to contain all the variables used during template expansion.

```ps
function New-Feature 
{
<#

.SYNOPSIS
    Scaffolds the code files needed to create a Feature generator. 

.DESCRIPTION
    
.PARAMETER OutputPath
    The optional output directory where the new Feature generator will be located.

#>

    [CmdletBinding()]
    param (
        [string] $OutputPath = $PWD
    )

    $TemplateDir = "$PSScriptRoot\Feature"

    # Resolve the specified output path and create it if necessary
    $OutputPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputPath)
    if (-not (Test-Path $OutputPath)) {
        New-Item $OutputPath -ItemType Directory -Force
    }

    # Build the model
    $Model = @{
        # Name = (Get-NamingConventions $Name)
        TemplateDir = $TemplateDir

        # Uncomment to add the data in the module to the model        
        # Module = $ModuleData 
    }

    # A list of paths in the template directory which will not be expanded.
    $Exclude = @()

    Expand-TemplateDirectory -InputPath $TemplateDir -OutputPath $OutputPath -Model $Model -Exclude $Excludes 
 
}
```

Add a new key value pair to the `$Model` hash table. Use a semicolon as a separator if you place multiple on the same line.

```
$Model = @{
    TemplateDir = $TemplateDir
    Name = "Psst"
}
```

Add a new file to the `Feature` directory.

```ps
PS> New-Item .\src\Feature\message.txt
```

Open it in your favorite text editor and add the following content.

```
$($Model.Name)... come check this out.
```




## Maintainers

- [Jacob Bruun](https://github.com/cobster)

## License

This project is [licensed under the MIT License](LICENSE)
