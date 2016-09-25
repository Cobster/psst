import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
    selector: '$($Model.Name.KebabCase)-app',
    template: '<router-outlet></router-outlet>'
})
export class AppComponent {

    constructor(router: Router) {

    }

}