// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8ifq-XuxU1OIKxEwVohxAcE7cywSajMk',
    appId: '1:858225352337:android:22b92e3fd16e5b860da930',
    messagingSenderId: '858225352337',
    projectId: 'keepmoviingdriver',
    storageBucket: 'keepmoviingdriver.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9fGijru0I7OOiyBYrmLoqxLzaaSggloc',
    appId: '1:858225352337:ios:cecd2958f82b9e300da930',
    messagingSenderId: '858225352337',
    projectId: 'keepmoviingdriver',
    storageBucket: 'keepmoviingdriver.appspot.com',
    iosClientId: '858225352337-5pidd3d6pck46viso60ri79qr7nf5ca4.apps.googleusercontent.com',
    iosBundleId: 'com.keepmoviingdriver.app',
  );
}
