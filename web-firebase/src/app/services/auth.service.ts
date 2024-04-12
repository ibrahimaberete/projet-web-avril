import { Injectable } from '@angular/core';
import { createUserWithEmailAndPassword, getAuth, setPersistence, signInWithEmailAndPassword, signOut, browserLocalPersistence, browserSessionPersistence } from "firebase/auth";

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor() { }

  async login(email: string, password: string): Promise<void> {
    const auth = getAuth();
    await setPersistence(auth, browserSessionPersistence);
    try {
      const userCredential = await signInWithEmailAndPassword(auth, email, password);
      const user = userCredential.user;
      const token = await user.getIdToken(); 
      sessionStorage.setItem('token', token); 
    } catch (error) {
      throw error;
    }
  }

  isLoggedIn(): boolean {
    const token = sessionStorage.getItem('token');
    return !!token;
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
    await setPersistence(auth, browserLocalPersistence);
    try {
      const userCredential = await createUserWithEmailAndPassword(auth, email, password);
      const user = userCredential.user;
      const token = await user.getIdToken(); 
      sessionStorage.setItem('token', token); 
    } catch (error) {
      throw error;
    }
  }
}