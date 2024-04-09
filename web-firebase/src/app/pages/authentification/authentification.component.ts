import { Component} from '@angular/core';
import { CommonModule } from '@angular/common';
import LoginComponent from '../../components/login/login.component';
import { MatCardModule } from '@angular/material/card';

@Component({
  selector: 'app-authentification',
  templateUrl: './authentification.component.html',
  imports:[CommonModule, LoginComponent,MatCardModule],
  standalone: true,
  styleUrls: ['./authentification.component.scss']
})
export class AuthentificationComponent {}
