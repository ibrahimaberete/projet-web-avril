import { Injectable } from '@angular/core';
import { FirebaseApp, initializeApp } from 'firebase/app';
import { getFirestore, collection, onSnapshot, addDoc, doc, updateDoc, deleteDoc, setDoc, getDoc, Firestore, DocumentData, query, where } from 'firebase/firestore';
import { Observable } from 'rxjs';
import { firebaseConfig } from '../environments/environment';
import { ImgCarousel } from '../interfaces/img-carousel';
import { getAuth } from 'firebase/auth';


@Injectable({
  providedIn: 'root'
})
export class CarouselService {

  private app: FirebaseApp ;
  private db: Firestore ;

  constructor() {
    this.app = initializeApp(firebaseConfig);
    this.db = getFirestore(this.app);
  }

  getCarouselData(onlyUserPosts: boolean): Observable<ImgCarousel[]> {
    const auth = getAuth();
    const currentUser = auth.currentUser;
    let carouselQuery = query(collection(this.db, 'carousel'));
  
    if (onlyUserPosts && currentUser) {
      carouselQuery = query(collection(this.db, 'carousel'), where('userId', '==', currentUser.uid));
    }
    
    return new Observable<ImgCarousel[]>((observer) => {
      const unsubscribe = onSnapshot(carouselQuery, (querySnapshot) => {
        const carouselData: ImgCarousel[] = [];
  
        querySnapshot.forEach((doc) => {
          const data = doc.data() as ImgCarousel;
          data['id'] = doc.id;
          carouselData.push(data);
        });
  
        observer.next(carouselData);
      });
  
      return unsubscribe;
    });
  }

  async add(data: ImgCarousel): Promise<void> {
    const auth = getAuth();
    const currentUser = auth.currentUser;
  
    if (!currentUser) {
      throw new Error('No user is currently signed in.');
    }
  
    const carouselRef = collection(this.db, 'carousel');
    const cityDocRef = doc(carouselRef, data.id);
  
    data.userId = currentUser.uid;
  
    try {
      await setDoc(cityDocRef, data);
    } catch (error) {
      throw error;
    }
  }

  async update(updatedData: ImgCarousel): Promise<void> {
    const carouselRef = collection(this.db, 'carousel');
    const cityDoc = doc(carouselRef, updatedData.id);

    try {
      await updateDoc(cityDoc, { img: updatedData.img });
    } catch (error) {
      throw error;
    }
  }

  async delete(item: ImgCarousel): Promise<void> {
    const carouselRef = collection(this.db, 'carousel');
    const cityDoc = doc(carouselRef, item.id);

    try {
      await deleteDoc(cityDoc);
    } catch (error) {
      throw error;
    }
  }

  async downloadImage(item: ImgCarousel):Promise<void> {
    const image = await fetch(item.img);
    const imageBlob = await image.blob();
    const imageURL = URL.createObjectURL(imageBlob);

    const link = document.createElement('a');
    link.href = imageURL;
    link.download = `image_${item.id}.jpg`;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  }

  async updateLikes(item: ImgCarousel):Promise<void> {
    try {
      const itemRef = doc(this.db, `carousel/${item.id}`);

      const snapshot = await getDoc(itemRef);
      const itemData = snapshot.data();

      const updatedLikes = itemData?.['likes'] + 1;

      await updateDoc(itemRef, { likes: updatedLikes });
    } catch (error) {
      throw error;
    }
  }
}
