import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';



@Component({
  selector: 'app-authentification',
  templateUrl: './authentification.component.html',
  styleUrls: ['./authentification.component.scss']
})
export class AuthentificationComponent implements OnInit {
  loginForm: FormGroup = new FormGroup({
    email: new FormControl(''),
    password: new FormControl(''),
  });

  registerForm: FormGroup = new FormGroup({
    email: new FormControl(''),
    password: new FormControl(''),
  });


  constructor(private authService: AuthService, private router: Router, private snackBar: MatSnackBar) {}

  ngOnInit() {
  }

  login() {
    const { email, password } = this.loginForm?.value;
    this.authService.login(email, password)
      .then(() => {
        this.router.navigate(['/home']);
        this.snackBar.open('Connexion réussie', 'Fermer', {
          duration: 2000,
          panelClass: ['mat-toolbar', 'mat-primary']
        });
      })
      .catch((error) => {
        console.error('Erreur de connexion : ', error.message);
      });
  }
}