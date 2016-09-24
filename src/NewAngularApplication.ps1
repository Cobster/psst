function New-AngularApplication 
{
    param (
        [string] $Name,
        [string] $Title = $Name,
        [string] $Styles
    )

    $TemplateDir = "$PSScriptRoot\templates\angular2\app"

    $Model = @{
        Name = (Get-NamingConventions $Name)
        Title = $Title
    }


    Expand-Template -InputFile "$TemplateDir\tsconfig.json" -OutputFile "$pwd\tsconfig.json" -Model $Model
    Expand-Template -InputFile "$TemplateDir\typings.json" -OutputFile "$pwd\typings.json" -Model $Model
    Expand-Template -InputFile "$TemplateDir\package.json" -OutputFile "$pwd\package.json" -Model $Model
    
    # Testing
    Expand-Template -InputFile "$TemplateDir\karma.conf.js" -OutputFile "$pwd\karma.conf.js" -Model $Model
    Expand-Template -InputFile "$TemplateDir\karma-test-shim.js" -OutputFile "$pwd\karma-test-shim.js" -Model $Model
    
    # Packaging
    Expand-Template -InputFile "$TemplateDir\webpack.config.js" -OutputFile "$pwd\webpack.config.js" -Model $Model
    Expand-Template -InputFile "$TemplateDir\webpack.test.js" -OutputFile "$pwd\webpack.test.js" -Model $Model
    Expand-Template -InputFile "$TemplateDir\webpack.helpers.js" -OutputFile "$pwd\webpack.helpers.js" -Model $Model

    #Documentation
    Expand-Template -InputFile "$TemplateDir\README.md" -OutputFile "$pwd\README.md" -Model $Model

    #Client-Side Application
    New-Item "$pwd\Client" -ItemType Directory
    Expand-Template -InputFile "$TemplateDir\client\vendor.ts" -OutputFile "$pwd\Client\vendor.ts" -Model $Model
    Expand-Template -InputFile "$TemplateDir\client\polyfills.ts" -OutputFile "$pwd\Client\polyfills.ts" -Model $Model
    Expand-Template -InputFile "$TemplateDir\client\main.ts" -OutputFile "$pwd\Client\main.ts" -Model $Model
    Expand-Template -Inputfile "$TemplateDir\client\index.html" -OutputFile "$pwd\Client\index.html" -Model $Model

    # Add a base styles file
    if (-not [String]::IsNullOrWhiteSpace($Styles)) {

        $StylesExtension = $Styles.ToLower()
        if ($StylesExtension -eq 'sass') {
            $StylesExtension = 'scss'
        }

        if ($StylesExtension -eq 'sass' -or $StylesExtension -eq 'scss') {
            Expand-Template -InputFile "$TemplateDir\client\styles.scss" -OutputFile "$pwd\Client\styles.scss" -Model $Model
        } 
        elseif ($StylesExtension -eq 'css') {
            Expand-Template -InputFile "$TemplateDir\client\styles.css" -OutputFile "$pwd\Client\styles.css" -Model $Model
        }
        elseif ($StylesExtension -eq 'less') {
            Expand-Template -InputFile "$TemplateDir\client\styles.less" -OutputFile "$pwd\Client\styles.less" -Model $Model
        }
    }

    # Root Module
    New-Item "$pwd\Client\app" -ItemType Directory
    Expand-Template -InputFile "$TemplateDir\client\app\app.module.ts" -OutputFile "$pwd\Client\app\app.module.ts" -Model $Model
    Expand-Template -InputFile "$TemplateDir\client\app\app.component.ts" -OutputFile "$pwd\Client\app\app.component.ts" -Model $Model
    Expand-Template -InputFile "$TemplateDir\client\app\app.routing.ts" -OutputFile "$pwd\Client\app\app.routing.ts" -Model $Model
}