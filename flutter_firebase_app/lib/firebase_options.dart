// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC1tnIXklCDCZ6CKVPVAx-o4fKO3oCrno0',
    appId: '1:177774586140:web:fbdd5a069a3e772aed32d9',
    messagingSenderId: '177774586140',
    projectId: 'projet-web-avril',
    authDomain: 'projet-web-avril.firebaseapp.com',
    storageBucket: 'projet-web-avril.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCG8tBt4esZeXfmx0NeHblZDPhwahPoWcA',
    appId: '1:177774586140:android:6a585f163eab3912ed32d9',
    messagingSenderId: '177774586140',
    projectId: 'projet-web-avril',
    storageBucket: 'projet-web-avril.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7YiuGmaOrFdcQDi2ipGMszdcNmYEHp80',
    appId: '1:177774586140:ios:a56cf016e12a5a1bed32d9',
    messagingSenderId: '177774586140',
    projectId: 'projet-web-avril',
    storageBucket: 'projet-web-avril.appspot.com',
    iosBundleId: 'com.example.flutterFirebaseApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7YiuGmaOrFdcQDi2ipGMszdcNmYEHp80',
    appId: '1:177774586140:ios:a9da27ca016669cfed32d9',
    messagingSenderId: '177774586140',
    projectId: 'projet-web-avril',
    storageBucket: 'projet-web-avril.appspot.com',
    iosBundleId: 'com.example.flutterFirebaseApp.RunnerTests',
  );
}
