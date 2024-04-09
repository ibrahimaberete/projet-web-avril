import { Component, Input } from '@angular/core';
import { ImgCarousel } from 'src/app/interfaces/img-carousel';
import { MatDialog } from '@angular/material/dialog';
import { CarouselService } from 'src/app/services/carousel.service';
import { CommonModule } from '@angular/common';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import CityDialogComponent from '../city-dialog/city-dialog.component';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-list-card',
  templateUrl: './list-card.component.html',
  styleUrls: ['./list-card.component.scss'],
  standalone: true,
  imports:[CommonModule,MatCardModule,MatIconModule,MatButtonModule]
})
export class ListCardComponent {
  constructor(
    private dialog: MatDialog,
    private carouselService: CarouselService
  ) { }

  @Input() city?: ImgCarousel[] = [];

  sendItemUpdate(item: ImgCarousel): void {
    this.openUpdateDialog(item);
  }

  openUpdateDialog(item: ImgCarousel): void {
    const dialogRef = this.dialog.open(CityDialogComponent, {
      width: '300px',
      data: item,
    });

    dialogRef.afterClosed().subscribe((result:ImgCarousel) => {
      if (result) {
        console.log(result);

        this.carouselService.update(result);
      }
    });
  }

  deleteItem(item: ImgCarousel): void {
    this.carouselService.delete(item);
  }

  downloadImage(item: ImgCarousel): void {
    this.carouselService.downloadImage(item);
  }

  updateLikes(item: ImgCarousel): void {
    this.carouselService.updateLikes(item);
  }

}
