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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyA2uDXTwi2cHYY3o0KoLhgK1WssMqE0ypM',
    appId: '1:746305726021:web:28c5da1ffc64c03aaae52c',
    messagingSenderId: '746305726021',
    projectId: 'hospital-66536',
    authDomain: 'hospital-66536.firebaseapp.com',
    storageBucket: 'hospital-66536.firebasestorage.app',
    measurementId: 'G-BCK9NDVL9Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDR4tFmEaVEfrjcKZVrpogvs_HdV3EnHpI',
    appId: '1:746305726021:android:e60092da41b4f82faae52c',
    messagingSenderId: '746305726021',
    projectId: 'hospital-66536',
    storageBucket: 'hospital-66536.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA2uDXTwi2cHYY3o0KoLhgK1WssMqE0ypM',
    appId: '1:746305726021:web:7b1ebdb6cf5d91eeaae52c',
    messagingSenderId: '746305726021',
    projectId: 'hospital-66536',
    authDomain: 'hospital-66536.firebaseapp.com',
    storageBucket: 'hospital-66536.firebasestorage.app',
    measurementId: 'G-Q86LWVQMGH',
  );
}
