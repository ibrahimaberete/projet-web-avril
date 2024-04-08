import { Component, Inject, signal } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

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
    @Inject(MAT_DIALOG_DATA) public data: any,
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
      const cityName = this.cityForm.get('cityName')?.value;
      const imageUrl = this.cityForm.get('imageUrl')?.value;
      const like = this.cityForm.get('like')?.value;

      const cityData = { id: cityName, img: imageUrl, likes: like };

      this.dialogRef?.close(cityData);
    }
  }

  onClose(): void {
    if (this.cityForm) {
    this.dialogRef?.close();
    }
  }

}
