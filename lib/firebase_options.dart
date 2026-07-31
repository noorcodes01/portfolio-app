import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Web not configured.');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError('Platform not supported.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSiTiQM-o40DjAYICU57b5AWoVZ4qdlCI',
    appId: '1:1047628605258:android:5de15713e65c283bf203b3',
    messagingSenderId: '1047628605258',
    projectId: 'portfolio-app-v2-b5fa6',
    storageBucket: 'portfolio-app-v2-b5fa6.firebasestorage.app',
  );
}