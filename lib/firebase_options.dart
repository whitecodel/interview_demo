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
    apiKey: 'AIzaSyAVYhaDWxoEHDqF5MV0T_oUEqjmdD2R26g',
    appId: '1:104093900360:web:958bf6a519c9f14879c27d',
    messagingSenderId: '104093900360',
    projectId: 'interview-demo-85602',
    authDomain: 'interview-demo-85602.firebaseapp.com',
    storageBucket: 'interview-demo-85602.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBIg54Ry8XXbloLeXJ6ocArQ2FnTvM_KmE',
    appId: '1:104093900360:android:7c7fede3764f400279c27d',
    messagingSenderId: '104093900360',
    projectId: 'interview-demo-85602',
    storageBucket: 'interview-demo-85602.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUpekIjesKpo7xYjwnzLcN4sAc_l_AFFE',
    appId: '1:104093900360:ios:2a56da97c1deb85879c27d',
    messagingSenderId: '104093900360',
    projectId: 'interview-demo-85602',
    storageBucket: 'interview-demo-85602.appspot.com',
    iosBundleId: 'com.example.interviewDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUpekIjesKpo7xYjwnzLcN4sAc_l_AFFE',
    appId: '1:104093900360:ios:2a56da97c1deb85879c27d',
    messagingSenderId: '104093900360',
    projectId: 'interview-demo-85602',
    storageBucket: 'interview-demo-85602.appspot.com',
    iosBundleId: 'com.example.interviewDemo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAVYhaDWxoEHDqF5MV0T_oUEqjmdD2R26g',
    appId: '1:104093900360:web:70a6b5113da305a679c27d',
    messagingSenderId: '104093900360',
    projectId: 'interview-demo-85602',
    authDomain: 'interview-demo-85602.firebaseapp.com',
    storageBucket: 'interview-demo-85602.appspot.com',
  );
}
