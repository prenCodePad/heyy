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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCLzTAMDy_DN20Kdt7oesaa7a-wgXOt8Xc',
    appId: '1:450200143151:android:94c7f59b66852692708dda',
    messagingSenderId: '450200143151',
    projectId: 'heyy-7c685',
    databaseURL: 'https://heyy-7c685-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'heyy-7c685.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1ccfPFYGSUTJv_KmyRJaxzS537VES2e0',
    appId: '1:450200143151:ios:53da04b7e25c0d19708dda',
    messagingSenderId: '450200143151',
    projectId: 'heyy-7c685',
    databaseURL: 'https://heyy-7c685-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'heyy-7c685.appspot.com',
    iosClientId: '450200143151-ch1sugr5liipnda22osctjaps9gsfumj.apps.googleusercontent.com',
    iosBundleId: 'com.skeleton.flutterApp',
  );
}
