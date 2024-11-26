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
        return macos;
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
    apiKey: 'AIzaSyDc-EsCm80vC6Ry4ckRg6mceCV1BYbZNpk',
    appId: '1:526148605420:web:21b36d609bc5598f121cc9',
    messagingSenderId: '526148605420',
    projectId: 'mobilepraktikum-e0650',
    authDomain: 'mobilepraktikum-e0650.firebaseapp.com',
    storageBucket: 'mobilepraktikum-e0650.firebasestorage.app',
    measurementId: 'G-9SQHV2Z7MN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAE4OxqQfNA99-7VpnvPq2H594Lnnz1Gt4',
    appId: '1:526148605420:android:670459a1a2044ab0121cc9',
    messagingSenderId: '526148605420',
    projectId: 'mobilepraktikum-e0650',
    storageBucket: 'mobilepraktikum-e0650.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFnT6yaHHa66zypiDvMEdfywN_svzSQKI',
    appId: '1:526148605420:ios:e0919fb8ad27485a121cc9',
    messagingSenderId: '526148605420',
    projectId: 'mobilepraktikum-e0650',
    storageBucket: 'mobilepraktikum-e0650.firebasestorage.app',
    iosBundleId: 'com.example.mobilepraktikum',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFnT6yaHHa66zypiDvMEdfywN_svzSQKI',
    appId: '1:526148605420:ios:e0919fb8ad27485a121cc9',
    messagingSenderId: '526148605420',
    projectId: 'mobilepraktikum-e0650',
    storageBucket: 'mobilepraktikum-e0650.firebasestorage.app',
    iosBundleId: 'com.example.mobilepraktikum',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDc-EsCm80vC6Ry4ckRg6mceCV1BYbZNpk',
    appId: '1:526148605420:web:636b0fbdd5c6805b121cc9',
    messagingSenderId: '526148605420',
    projectId: 'mobilepraktikum-e0650',
    authDomain: 'mobilepraktikum-e0650.firebaseapp.com',
    storageBucket: 'mobilepraktikum-e0650.firebasestorage.app',
    measurementId: 'G-EVFNLR9L1J',
  );
}
