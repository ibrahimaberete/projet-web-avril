import { Component, Input } from '@angular/core';
import { ImgCarousel } from 'src/app/interfaces/img-carousel';
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

  sendItemUpdate(item: any) {
    this.openUpdateDialog(item);
  }

  openUpdateDialog(item: any) {
    const dialogRef = this.dialog.open(CityDialogComponent, {
      width: '300px',
      data: item,
    });

    dialogRef.afterClosed().subscribe((result) => {
      if (result) {
        this.carouselService.update(result);
      }
    });
  }

  deleteItem(item: any) {
    this.carouselService.delete(item);
  }

  downloadImage(item: ImgCarousel) {
    this.carouselService.downloadImage(item);
  }

  updateLikes(item: any) {
    this.carouselService.updateLikes(item);
  }

}
