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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // ===== Android =====
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDW-YOUR_ACTUAL_KEY_FROM_JSON', // 👈 استبدلي هذا الجزء بـ current_key الموجود في ملف google-services.json
    appId: '1:219824011470:android:b1f718d2bbec3ca897b89f', 
    messagingSenderId: '219824011470', 
    projectId: 'laza-5ec49', 
    storageBucket: 'laza-5ec49.appspot.com', 
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDW-YOUR_ACTUAL_KEY_FROM_JSON',
    appId: '1:219824011470:ios:YOUR_IOS_APP_ID',
    messagingSenderId: '219824011470',
    projectId: 'laza-5ec49',
    storageBucket: 'laza-5ec49.appspot.com',
    iosClientId: 'YOUR_IOS_CLIENT_ID',
    iosBundleId: 'com.example.laza_app_new',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDW-YOUR_ACTUAL_KEY_FROM_JSON',
    appId: '1:219824011470:web:YOUR_WEB_APP_ID',
    messagingSenderId: '219824011470',
    projectId: 'laza-5ec49',
    storageBucket: 'laza-5ec49.appspot.com',
    authDomain: 'laza-5ec49.firebaseapp.com',
  );
}