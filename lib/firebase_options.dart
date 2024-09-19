// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBw5ZyfKvufvgcUaxzLy-n6ScARF9F7qfk',
    appId: '1:66661545222:web:cac8483cd0ea0c79409a87',
    messagingSenderId: '66661545222',
    projectId: 'house-easefyp',
    authDomain: 'house-easefyp.firebaseapp.com',
    storageBucket: 'house-easefyp.appspot.com',
    measurementId: 'G-5JVVM8W8NY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxtNe4Pl7--XPr7acMzcyjScEf0c2-LGw',
    appId: '1:66661545222:android:c6e3d207e9012d73409a87',
    messagingSenderId: '66661545222',
    projectId: 'house-easefyp',
    storageBucket: 'house-easefyp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9JdGgmmuc7kyWrJMRyPwuWm_nj_DQJcI',
    appId: '1:66661545222:ios:c144d9eddb9ba481409a87',
    messagingSenderId: '66661545222',
    projectId: 'house-easefyp',
    storageBucket: 'house-easefyp.appspot.com',
    iosBundleId: 'com.example.shiftEaseFyp',
  );
}
