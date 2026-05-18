import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get web => const FirebaseOptions(
    apiKey: 'AIzaSyAZfHPqwR2xBmYFxXZ8IwgwogLrrK9kOf0',
    appId:
        '1:194258872342:web:6e77725e864be459eeed37', // Assuming similar pattern
    messagingSenderId: '194258872342',
    projectId: 'vigilantai-vision',
    authDomain: 'vigilantai-vision.firebaseapp.com',
    storageBucket: 'vigilantai-vision.firebasestorage.app',
    databaseURL:
        'https://vigilantai-vision-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  static FirebaseOptions get android => const FirebaseOptions(
    apiKey: 'AIzaSyAZfHPqwR2xBmYFxXZ8IwgwogLrrK9kOf0',
    appId: '1:194258872342:android:ce77725e864be459eeed37',
    messagingSenderId: '194258872342',
    projectId: 'vigilantai-vision',
    storageBucket: 'vigilantai-vision.firebasestorage.app',
    databaseURL:
        'https://vigilantai-vision-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform.',
        );
    }
  }
}
