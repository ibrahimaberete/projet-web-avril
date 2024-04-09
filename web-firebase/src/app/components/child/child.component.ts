import { Component, Input } from '@angular/core';
import { ImgCarousel, UpdateImgCarousel } from 'src/app/interfaces/img-carousel';
import { CityDialogComponent } from '../city-dialog/city-dialog.component';
import { MatDialog } from '@angular/material/dialog';
import { CarouselService } from 'src/app/services/carousel.service';

@Component({
  selector: 'app-child',
  templateUrl: './child.component.html',
  styleUrls: ['./child.component.scss']
})
export class ChildComponent {
  constructor(
    private dialog: MatDialog,
    private carouselService: CarouselService
  ) { }

  @Input() city?: ImgCarousel[] = [];

  sendItemUpdate(item: ImgCarousel):void {
    this.openUpdateDialog(item);
  }

  openUpdateDialog(item: ImgCarousel):void {
    const dialogRef = this.dialog.open(CityDialogComponent, {
      width: '300px',
      data: item,
    });

    dialogRef.afterClosed().subscribe((result:UpdateImgCarousel) => {
      if (result) {
        this.carouselService.update(result);
      }
    });
  }

  deleteItem(item: ImgCarousel):void {
    this.carouselService.delete(item);
  }

  downloadImage(item: ImgCarousel):void {
    this.carouselService.downloadImage(item);
  }

  updateLikes(item: ImgCarousel):void {
    this.carouselService.updateLikes(item);
  }

}
