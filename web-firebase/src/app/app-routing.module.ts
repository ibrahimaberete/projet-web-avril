import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from './pages/authentification/authentifcation.guard';
import LoginComponent from './components/login/login.component';
import RegisterComponent from './components/register/register.component';
import MainComponent from './pages/main/home.component';

const routes: Routes = [
  {path: '', redirectTo: '/auth/login', pathMatch: 'full'},
  {path: 'home', component: MainComponent, canActivate: [AuthGuard]},
  {path: 'auth', children: [
    {path: 'login', component: LoginComponent},
    {path: 'register', component: RegisterComponent},
  ]},
  {path: '**', redirectTo: '/auth/login'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
