import { ModuleWithProviders } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

const itemsRoutes: Routes = [
    // { path: '', component: ItemsComponent }
];

export const ItemsRoutingProviders: any[] = [

];

export const ItemsRouting: ModuleWithProviders = RouterModule.forChild(itemsRoutes);