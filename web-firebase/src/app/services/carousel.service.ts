import { Injectable } from '@angular/core';
import { initializeApp } from 'firebase/app';
import { getFirestore, collection, onSnapshot, addDoc, doc, updateDoc, deleteDoc, setDoc, getDoc } from 'firebase/firestore';
import { Observable } from 'rxjs';
import { firebaseConfig } from '../environments/environment';
import { ImgCarousel } from '../interfaces/img-carousel';



@Injectable({
  providedIn: 'root'
})
export class CarouselService {

  private app: any;
  private db: any;

  constructor() {
    this.app = initializeApp(firebaseConfig);
    this.db = getFirestore(this.app);
  }

  async add(city: any): Promise<void> {
    const carouselRef = collection(this.db, 'carousel');
    const cityDocRef = doc(carouselRef, city.id);

    try {
      await setDoc(cityDocRef, city);
      console.log(city);
    } catch (error) {
      throw error;
    }
  }
}
