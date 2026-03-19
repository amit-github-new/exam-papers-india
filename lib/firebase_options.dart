import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDjlUUawa6U-0r2OqtMPeAjisQr32jhqoE',
    appId: '1:704391042507:android:838c7d9a4b40abb975d24e',
    messagingSenderId: '704391042507',
    projectId: 'exam-papers-india',
    storageBucket: 'exam-papers-india.firebasestorage.app',
  );
}
