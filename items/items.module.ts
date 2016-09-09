import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ItemsRouting, ItemsRoutingProviders } from './items.routing';

@NgModule({
	declarations: [
		
	],
	imports: [
		CommonModule,
		ItemsRouting
	],
	exports: [
		
	],
	providers: [
		ItemsRoutingProviders
	]
})
export class ItemsModule { }