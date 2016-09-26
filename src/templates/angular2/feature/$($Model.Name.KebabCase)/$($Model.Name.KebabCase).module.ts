$([String]::Join("`r`n", $Model.Module.Imports))

@NgModule({
    $(New-Metadata -Metadata declarations -Model $Model.Module.Metadata.Declarations),
    $(New-Metadata -Metadata exports -Model $Model.Module.Metadata.Exports),
    $(New-Metadata -Metadata imports -Model $Model.Module.Metadata.Imports),
    $(New-Metadata -Metadata providers -Model $Model.Module.Metadata.Providers)
})
export class $($Name)Module { }