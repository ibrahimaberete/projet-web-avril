import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router, RouterModule } from '@angular/router';
import { ErrorMessage } from 'src/app/interfaces/img-carousel';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
  standalone: true,
  imports: [
    CommonModule,
    MatFormFieldModule,
    ReactiveFormsModule,
    MatInputModule,
    MatButtonModule,
    RouterModule,
    MatIconModule
  ],
})
export default class LoginComponent {
  loginForm: FormGroup = new FormGroup({
    email: new FormControl('',
      [Validators.required,
      Validators.email]),
    password: new FormControl(''),
  });

  constructor(
    private authService: AuthService,
    private router: Router,
    private snackBar: MatSnackBar
  ) { }

  hide = true;

  login() {
    const { email, password } = this.loginForm?.value;
    this.authService
      .login(email, password)
      .then(() => {
        this.router.navigate(['/home']);

        this.snackBar.open('Connexion réussie', 'Fermer', {
          duration: 2000,
          panelClass: ['mat-toolbar', 'mat-primary'],
        });
      })
      .catch((error) => {
        let message: ErrorMessage; // Initialize the message variable with an empty string
        console.log('Erreur de connexion : ', error);
       
       
        message = 'Email/password are not correct.';
        this.snackBar.open(message, 'Fermer', {
          duration: 3000,
        });
      });
  }
}
