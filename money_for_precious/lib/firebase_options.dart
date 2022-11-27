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
    apiKey: 'AIzaSyC7ElxVSfoR4wSJcTOeKx3ZanbfQso_fLI',
    appId: '1:199550756345:web:ed92df1649944dda3f0928',
    messagingSenderId: '199550756345',
    projectId: 'moneytoma-0',
    authDomain: 'moneytoma-0.firebaseapp.com',
    databaseURL: 'https://moneytoma-0-default-rtdb.firebaseio.com',
    storageBucket: 'moneytoma-0.appspot.com',
    measurementId: 'G-DGWFY45BX6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBk_nrcdus6_J97wyqbuwkBNcOeoCk8N6c',
    appId: '1:199550756345:android:20b8772aa0ac56aa3f0928',
    messagingSenderId: '199550756345',
    projectId: 'moneytoma-0',
    databaseURL: 'https://moneytoma-0-default-rtdb.firebaseio.com',
    storageBucket: 'moneytoma-0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgf11PLbPHQBJcX91Nu3pGRTs-mnkpOnA',
    appId: '1:199550756345:ios:2ee5418b33f106673f0928',
    messagingSenderId: '199550756345',
    projectId: 'moneytoma-0',
    databaseURL: 'https://moneytoma-0-default-rtdb.firebaseio.com',
    storageBucket: 'moneytoma-0.appspot.com',
    iosClientId: '199550756345-p1nb2lv5josc8bbmdtn55lcmsv5ak8u9.apps.googleusercontent.com',
    iosBundleId: 'com.example.moneyForPrecious',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDgf11PLbPHQBJcX91Nu3pGRTs-mnkpOnA',
    appId: '1:199550756345:ios:2ee5418b33f106673f0928',
    messagingSenderId: '199550756345',
    projectId: 'moneytoma-0',
    databaseURL: 'https://moneytoma-0-default-rtdb.firebaseio.com',
    storageBucket: 'moneytoma-0.appspot.com',
    iosClientId: '199550756345-p1nb2lv5josc8bbmdtn55lcmsv5ak8u9.apps.googleusercontent.com',
    iosBundleId: 'com.example.moneyForPrecious',
  );
}
