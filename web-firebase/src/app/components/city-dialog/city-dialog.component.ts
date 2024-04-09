import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ImgCarousel } from 'src/app/interfaces/img-carousel';
import { CarouselService } from 'src/app/services/carousel.service';

@Component({
  selector: 'app-city-dialog',
  templateUrl: './city-dialog.component.html',
  styleUrls: ['./city-dialog.component.scss']
})
export class CityDialogComponent {

  public cityForm: FormGroup;
  public isUpdate: boolean = false;

  constructor(
    public dialogRef: MatDialogRef<CityDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: ImgCarousel,
    private carouselService: CarouselService,
    private fb: FormBuilder
  ) {
    this.cityForm = this.fb.group({
      cityName: ['', Validators.required],
      imageUrl: ['', Validators.required],
      like: 0
    });

    if (data) {
      this.isUpdate = true;
      this.cityForm.setValue({
        cityName: this.data.id,
        imageUrl: this.data.img,
        like: this.data.likes
      });
    }
  }

  onSubmit(): void {
    if (this.cityForm.valid) {
      const cityName: string = this.cityForm.get('cityName')?.value ?? '';
      const imageUrl: string = this.cityForm.get('imageUrl')?.value ?? '';
      const like: number = this.cityForm.get('like')?.value ?? '';

      // Vérifiez que cityName n'est pas vide
      if (!cityName) {
        alert('Le nom de la ville ne peut pas être vide');
        return;
      }

      const cityData = { id: cityName, img: imageUrl, likes: like };

      this.carouselService.update({ oldId:this.data.id,newId:cityName,...cityData});

      this.dialogRef?.close(cityData);
    }
  }
  onClose(): void {
    if (this.cityForm) {
    this.dialogRef?.close();
    }
  }

  onNoClick(): void {
    this.dialogRef.close();
  }
}
