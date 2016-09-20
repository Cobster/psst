import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppComponent } from './app.component';
import { AppRouting, AppRoutingProviders } from './app.routing';

@NgModule({
    bootstrap: [AppComponent],
    declarations: [
        AppComponent
    ],
    imports: [
        BrowserModule,
        AppRouting
    ],
    providers: [AppRoutingProviders]
})
export class AppModule { }
