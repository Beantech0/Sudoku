// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
//  await Firebase.initializeApp(
//    options: DefaultFirebaseOptions.currentPlatform,
//  );
/// ```
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
    apiKey: 'AIzaSyBAzXWUgscnWFJxcE1xDDhm7nd0I4FcvKY',
    appId: '1:163166246802:web:d3a4f509cbbc2b68d1d34b',
    messagingSenderId: '163166246802',
    projectId: 'sudokuflutter-ef5bb',
    authDomain: 'sudokuflutter-ef5bb.firebaseapp.com',
    storageBucket: 'sudokuflutter-ef5bb.appspot.com',
    measurementId: 'G-1D4TSZ91E3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBooqWhkKSrRV-6FTnRzZDi99vu27zjris',
    appId: '1:163166246802:android:1ac6139c0cfce752d1d34b',
    messagingSenderId: '163166246802',
    projectId: 'sudokuflutter-ef5bb',
    storageBucket: 'sudokuflutter-ef5bb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyARbqSpT8kk-mxFg7xWZDRIFwsRnPc3CRo',
    appId: '1:163166246802:ios:26954f5e70955e5dd1d34b',
    messagingSenderId: '163166246802',
    projectId: 'sudokuflutter-ef5bb',
    storageBucket: 'sudokuflutter-ef5bb.appspot.com',
    iosBundleId: 'com.example.sudoku',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyARbqSpT8kk-mxFg7xWZDRIFwsRnPc3CRo',
    appId: '1:163166246802:ios:da1066b1601280a1d1d34b',
    messagingSenderId: '163166246802',
    projectId: 'sudokuflutter-ef5bb',
    storageBucket: 'sudokuflutter-ef5bb.appspot.com',
    iosBundleId: 'com.example.sudoku.RunnerTests',
  );
}
