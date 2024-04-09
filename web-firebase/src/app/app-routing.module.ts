import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MainComponent } from './components/main/main.component';
import { AuthGuard } from './components/authentification/authentifcation.guard';
import { AuthentificationComponent } from './components/authentification/authentification.component';
import { RegisterComponent } from './components/register/register.component';

const routes: Routes = [
  {path: 'home', component: MainComponent, canActivate: [AuthGuard]},
  {path: 'login', component: AuthentificationComponent},
  {path: 'register', component: RegisterComponent},
  {path: '**', redirectTo: 'login'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }