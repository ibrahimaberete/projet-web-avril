import { Injectable } from '@angular/core';
import { createUserWithEmailAndPassword, getAuth, signInWithEmailAndPassword, signOut } from "firebase/auth";


@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor() { }

  async login(email: string, password: string): Promise<void> {
    const auth = getAuth();
    try {
      await signInWithEmailAndPassword(auth, email, password);
    } catch (error) {
      throw error;
    }
  }

  isLoggedIn(): boolean {
    const auth = getAuth();
    return auth.currentUser !== null;
  }

  async logout(): Promise<void> {
    const auth = getAuth();
    try {
      await signOut(auth);
    } catch (error) {
      throw error;
    }
  }
  async register(email: string, password: string): Promise<void> {
    const auth = getAuth();
    try {
      await createUserWithEmailAndPassword(auth, email, password);
    } catch (error) {
      throw error;
    }
  }

}
