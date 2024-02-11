// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
    apiKey: 'AIzaSyCefoHQFuLV3hi5Iiy994K1tVT6B9Mnv2E',
    appId: '1:995024296435:web:e04a3488d207470e06da86',
    messagingSenderId: '995024296435',
    projectId: 'envawareness-game',
    authDomain: 'envawareness-game.firebaseapp.com',
    storageBucket: 'envawareness-game.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD21gHg5t3UAp3TlA-wgORw39MxVBMacIQ',
    appId: '1:995024296435:android:b7597cf160ce20b006da86',
    messagingSenderId: '995024296435',
    projectId: 'envawareness-game',
    storageBucket: 'envawareness-game.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8X-9qzjx0VUZ5XKr6cpc-TyxpDtlB-Cs',
    appId: '1:995024296435:ios:059f5db47b8e8ac406da86',
    messagingSenderId: '995024296435',
    projectId: 'envawareness-game',
    storageBucket: 'envawareness-game.appspot.com',
    iosBundleId: 'challenge.global.envawareness',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8X-9qzjx0VUZ5XKr6cpc-TyxpDtlB-Cs',
    appId: '1:995024296435:ios:1b21761d232ef8d306da86',
    messagingSenderId: '995024296435',
    projectId: 'envawareness-game',
    storageBucket: 'envawareness-game.appspot.com',
    iosBundleId: 'challenge.global.envawareness.RunnerTests',
  );
}
