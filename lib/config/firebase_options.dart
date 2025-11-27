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
    apiKey: 'AIzaSyBpaz5Y3YWG-JwxjSUS39pLttjk33ziZGI',
    appId: '1:893997668308:web:ab354f10e68d22a8c86841',
    messagingSenderId: '893997668308',
    projectId: 'b11-app-9543c',
    authDomain: 'b11-app-9543c.firebaseapp.com',
    storageBucket: 'b11-app-9543c.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3TuDNpsD0HM-ds6gszOzP8t5ipejhC3I',
    appId: '1:893997668308:android:b8edbb878677df8cc86841',
    messagingSenderId: '893997668308',
    projectId: 'b11-app-9543c',
    storageBucket: 'b11-app-9543c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEGRhm0RQTjms9aI3ufLk8ap-_Rt1-pKQ',
    appId: '1:893997668308:ios:28f65b4ba89f4f6cc86841',
    messagingSenderId: '893997668308',
    projectId: 'b11-app-9543c',
    storageBucket: 'b11-app-9543c.firebasestorage.app',
    iosBundleId: 'com.example.b11App',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBEGRhm0RQTjms9aI3ufLk8ap-_Rt1-pKQ',
    appId: '1:893997668308:ios:28f65b4ba89f4f6cc86841',
    messagingSenderId: '893997668308',
    projectId: 'b11-app-9543c',
    storageBucket: 'b11-app-9543c.firebasestorage.app',
    iosBundleId: 'com.example.b11App',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBpaz5Y3YWG-JwxjSUS39pLttjk33ziZGI',
    appId: '1:893997668308:web:f902fd67322c5e93c86841',
    messagingSenderId: '893997668308',
    projectId: 'b11-app-9543c',
    authDomain: 'b11-app-9543c.firebaseapp.com',
    storageBucket: 'b11-app-9543c.firebasestorage.app',
  );
}
