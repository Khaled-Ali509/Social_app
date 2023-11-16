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
    apiKey: 'AIzaSyAL4LLUvgKcS8yGJjMy3FnBCrPA6MeDgxQ',
    appId: '1:539949166220:web:f66ece5562f276b9fa55a9',
    messagingSenderId: '539949166220',
    projectId: 'social-app-a426a',
    authDomain: 'social-app-a426a.firebaseapp.com',
    storageBucket: 'social-app-a426a.appspot.com',
    measurementId: 'G-JM27SSPJWQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzkSfrD7RMymMbLYkHsR1gHTl3lFizdIo',
    appId: '1:539949166220:android:078ee8093991e401fa55a9',
    messagingSenderId: '539949166220',
    projectId: 'social-app-a426a',
    storageBucket: 'social-app-a426a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmodI6kale7pNinQNnf71iKodMVqZx4xo',
    appId: '1:539949166220:ios:0d9c73764a30709ffa55a9',
    messagingSenderId: '539949166220',
    projectId: 'social-app-a426a',
    storageBucket: 'social-app-a426a.appspot.com',
    iosBundleId: 'com.example.socialApp',
  );
}