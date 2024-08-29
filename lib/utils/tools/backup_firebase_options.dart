import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_core/firebase_core.dart';
import 'package:paddle_jakarta/utils/tools/log.dart';

class DefaultFirebaseOptions {
  static Map<String, dynamic>? _jsonData;

  static Future<FirebaseOptions> get currentPlatform async {
    if (_jsonData == null) {
      final jsonString = await rootBundle.loadString('assets/firebase_options.json');
      _jsonData = jsonDecode(jsonString);
    }
    return _getOptionsForPlatform(_jsonData!);
  }

  static FirebaseOptions _getOptionsForPlatform(Map<String, dynamic> jsonData) {
    if (kIsWeb) {
      return _createFirebaseOptions(jsonData['web']);
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _createFirebaseOptions(jsonData['android']);
      case TargetPlatform.iOS:
        return _createFirebaseOptions(jsonData['ios']);
      case TargetPlatform.macOS:
        return _createFirebaseOptions(jsonData['macos']);
      case TargetPlatform.windows:
        return _createFirebaseOptions(jsonData['windows']);
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

  static FirebaseOptions _createFirebaseOptions(Map<String, dynamic> platformData) {
    Log.yellow('FirebaseOptions databaseURL: ${platformData['databaseURL']}');
    return FirebaseOptions(
      apiKey: platformData['apiKey'],
      appId: platformData['appId'],
      messagingSenderId: platformData['messagingSenderId'],
      projectId: platformData['projectId'],
      databaseURL: platformData['databaseURL'],
      storageBucket: platformData['storageBucket'],
      authDomain: platformData['authDomain'],
      measurementId: platformData['measurementId'],
    );
  }
}
