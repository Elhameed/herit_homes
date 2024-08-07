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
    apiKey: 'AIzaSyAGkKHagF3CHlPchrIB9Nz6jINqewIwc-Q',
    appId: '1:482608032076:web:e37ae57d161c74d9c247e9',
    messagingSenderId: '482608032076',
    projectId: 'herit-3581f',
    authDomain: 'herit-3581f.firebaseapp.com',
    storageBucket: 'herit-3581f.appspot.com',
    measurementId: 'G-DZ85Y066C7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwju851HqnEg21BusLAZrzOzKHidueunM',
    appId: '1:482608032076:android:c86342dc3d22b1ebc247e9',
    messagingSenderId: '482608032076',
    projectId: 'herit-3581f',
    storageBucket: 'herit-3581f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2frYup8rzzTnKrJC_W5PkAr0NM46ZB3I',
    appId: '1:482608032076:ios:a95d1dff16b020abc247e9',
    messagingSenderId: '482608032076',
    projectId: 'herit-3581f',
    storageBucket: 'herit-3581f.appspot.com',
    iosBundleId: 'com.example.heritHomes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB2frYup8rzzTnKrJC_W5PkAr0NM46ZB3I',
    appId: '1:482608032076:ios:a95d1dff16b020abc247e9',
    messagingSenderId: '482608032076',
    projectId: 'herit-3581f',
    storageBucket: 'herit-3581f.appspot.com',
    iosBundleId: 'com.example.heritHomes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAGkKHagF3CHlPchrIB9Nz6jINqewIwc-Q',
    appId: '1:482608032076:web:a6bf8ed89d243a20c247e9',
    messagingSenderId: '482608032076',
    projectId: 'herit-3581f',
    authDomain: 'herit-3581f.firebaseapp.com',
    storageBucket: 'herit-3581f.appspot.com',
    measurementId: 'G-08YXNV7QLS',
  );
}
