import { Component, OnInit, OnDestroy } from '@angular/core';
import { ImgCarousel } from 'src/app/interfaces/img-carousel';
import { CarouselService } from 'src/app/services/carousel.service';
import { CityDialogComponent } from '../city-dialog/city-dialog.component';
import { MatDialog } from '@angular/material/dialog';
import { Subscription } from 'rxjs';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.scss']
})
export class MainComponent implements OnInit, OnDestroy {

  imgCarousel: ImgCarousel[] = [];
  private carouselDataSubscription: Subscription | undefined;


  constructor(private carouselService: CarouselService, 
    private dialog: MatDialog, 
    private router: Router,
     private authService: AuthService) {}

  ngOnInit(): void {
    this.carouselDataSubscription = this.carouselService.getCarouselData().subscribe((data) => {
      this.imgCarousel = data;
      console.log('carousel', this.imgCarousel);
    });
  }

  ngOnDestroy(): void {
    if (this.carouselDataSubscription) {
      this.carouselDataSubscription.unsubscribe();
    }
  }

  openDialog(): void {
    const dialogRef = this.dialog.open(CityDialogComponent, {
      width: '300px',
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.carouselService.add(result);
      }
    });
  }

  logout() {
    this.authService.logout()
      .then(() => {
        this.router.navigate(['/login']);
      })
      .catch((error: { message: any; }) => {
        console.error('Erreur de déconnexion : ', error.message);
      });
  }
}
