export interface ImgCarousel {
  id?: string;
  img: string;
  likes?: number;
  userId?: string;
}


export type ErrorMessage='The account already exists for that email.'|'The email address is not valid.'|'Email/password accounts are not enabled.'|'The password is too weak.'|'An unknown error occurred.' | 'Email/password are not correct.'
