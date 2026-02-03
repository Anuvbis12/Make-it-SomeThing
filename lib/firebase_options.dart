// File ini biasanya digenerate otomatis oleh FlutterFire CLI.
// Karena saya tidak bisa menjalankan CLI, saya buatkan template dummy.
// Anda HARUS mengganti isi file ini dengan hasil generate dari perintah:
// flutterfire configure

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'API-KEY-WEB',
    appId: 'APP-ID-WEB',
    messagingSenderId: 'SENDER-ID',
    projectId: 'PROJECT-ID',
    authDomain: 'PROJECT-ID.firebaseapp.com',
    storageBucket: 'PROJECT-ID.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'API-KEY-ANDROID',
    appId: 'APP-ID-ANDROID',
    messagingSenderId: 'SENDER-ID',
    projectId: 'PROJECT-ID',
    storageBucket: 'PROJECT-ID.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'API-KEY-IOS',
    appId: 'APP-ID-IOS',
    messagingSenderId: 'SENDER-ID',
    projectId: 'PROJECT-ID',
    storageBucket: 'PROJECT-ID.appspot.com',
    iosBundleId: 'com.example.chaining',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'API-KEY-MACOS',
    appId: 'APP-ID-MACOS',
    messagingSenderId: 'SENDER-ID',
    projectId: 'PROJECT-ID',
    storageBucket: 'PROJECT-ID.appspot.com',
    iosBundleId: 'com.example.chaining',
  );
}
