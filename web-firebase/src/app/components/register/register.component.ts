import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { AbstractControl, ValidatorFn } from '@angular/forms';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { AuthService } from 'src/app/services/auth.service';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss'],
  imports: [
    CommonModule,
    MatSnackBarModule,
    MatCardModule,
    MatFormFieldModule,
    ReactiveFormsModule,
    MatInputModule,
    MatButtonModule,
    RouterModule
  ],
  standalone: true,
})
export default class RegisterComponent {
  passwordMatchValidator(
    control: AbstractControl
  ): { [key: string]: boolean } | null {
    const password = control.get('password')?.value;
    const confirmPassword = control.get('confirmPassword')?.value;

    return password === confirmPassword ? null : { mismatch: true };
  }

  registerForm: FormGroup = new FormGroup(
    {
      email: new FormControl(''),
      password: new FormControl('', [
        Validators.required,
        Validators.pattern(/^(?=.*[a-z])/), // Au moins une lettre minuscule
        Validators.pattern(/^(?=.*[A-Z])/), // Au moins une lettre majuscule
        Validators.pattern(/^(?=.*\d)/), // Au moins un chiffre
        Validators.minLength(8), // Au moins 8 caractères de lon
      ]),
      confirmPassword: new FormControl(''),
    },
    { validators: this.passwordMatchValidator }
  );

  constructor(
    private authService: AuthService,
    private router: Router,
    private snackBar: MatSnackBar
  ) {}

  register() {
    const { email, password, confirmPassword } = this.registerForm?.value;

    if (password !== confirmPassword) {
      this.snackBar.open('Les mots de passe ne correspondent pas.', 'Fermer', {
        duration: 3000,
      });
      return;
    }

    this.authService
      .register(email, password)
      .then(() => {
        this.router.navigate(['/home']);
      })
      .catch((error) => {
        let message;
        console.log('Erreur de connexion : ', error);
        switch (error.code) {
          case 'auth/email-already-in-use':
            message = 'The account already exists for that email.';
            break;
          case 'auth/invalid-email':
            message = 'The email address is not valid.';
            break;
          case 'auth/operation-not-allowed':
            message = 'Email/password accounts are not enabled.';
            break;
          case 'auth/weak-password':
            message = 'The password is too weak.';
            break;
          default:
            message = 'An unknown error occurred.';
            break;
        }
        this.snackBar.open(message, 'Fermer', {
          duration: 3000,
        });
      });
  }
}
