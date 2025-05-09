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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDEQ04XKvxet_Ryipzu7CUZCus2GCaNu1Q',
    appId: '1:565214622762:android:8a571190f4749c0a83bf53',
    messagingSenderId: '565214622762',
    projectId: 'rideway-8fdf6',
    storageBucket: 'rideway-8fdf6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBp0CsMHL2Bod9HRFg0B8CGeqoQ6ALkpOg',
    appId: '1:565214622762:ios:acdf1e4aa03476bb83bf53',
    messagingSenderId: '565214622762',
    projectId: 'rideway-8fdf6',
    storageBucket: 'rideway-8fdf6.firebasestorage.app',
    iosBundleId: 'com.coderex.rideway',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCn4zRhcNhCzvLB5YJ6shLBqjcLsyk7FjQ',
    appId: '1:565214622762:web:7361330834030ded83bf53',
    messagingSenderId: '565214622762',
    projectId: 'rideway-8fdf6',
    authDomain: 'rideway-8fdf6.firebaseapp.com',
    storageBucket: 'rideway-8fdf6.firebasestorage.app',
    measurementId: 'G-BMGZSJX134',
  );
}
