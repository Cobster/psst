# Psst - PowerShell Scaffolding Tool

Psst is a template-based file generator written in PowerShell.  Its purpose is to quickly 
create files from templates for any development language.  Generated files are created 
using predefined templates that use PowerShell's string replacement/interpolation syntax.

Psst also comes with a predefined set of templates and functions that can simplify the 
creation of application building blocks.

The initial set of building blocks being developed are for Angular2.  The file templates 
generated are powershell equivalents to those created by the 
[angular-cli](https://github.com/angular/angular-cli) project. 

## Example psst templates

**Important!** Do not use double quotes when defining a template. This will cause the PowerShell to 
evaluate the replacement variables during the initialization of the template. We want the expansion to 
occur inside the Expand-Template function call, so the template must be defined as a string literal.

#### A string template example 

    
    # Using double quotes will cause 
    $template = '$Greeting $Subject'

    Expand-Template $template -Greeting "Hello" -Subject "World"

Outputs:

    Hello World

#### A here-string template example

    $template = @'
        
    using System;

    namespace $Namespace
    {
        public class $Class 
        {
            public $Class() 
            {

            }
        }
    }

    '@

    Expand-Template $template -Class XWing -Namespace StarWars.Vehicles

Outputs:

    using System;
    
    namespace StarWars.Vehicles
    {
        public class XWing
        {
            public XWing()
            {

            }
        }
    }

#### Template file example

service.ts:

    import { Injectable } from '@angular/core';

    @Injectable()
    export class $($Name)Service {
        constructor() { }
    }

Code:

    Expand-Template -InputFile service.ts -Name My

Outputs:

    import { Injectable } from '@angular/core';

    @Injectable()
    export class MyService {
        constructor() { }
    }

## Angular 2 scaffolding functions

#### New-AngularApplication

#### New-AngularComponent

#### New-AngularFeature

#### New-AngularService

## Maintainers

- [Jacob Bruun](https://github.com/cobster) - [Automate all the things](http://jacobbruun.com)

## License

This project is [licensed under the MIT License](LICENSE)
