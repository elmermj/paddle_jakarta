import 'package:flutter/foundation.dart'; // For kDebugMode

class Log {
  static void red(String msg) {
    if (kDebugMode) {
      debugPrint('\x1B[31m$msg\x1B[0m');
    }
  }

  static void green(String msg) {
    if (kDebugMode) {
      debugPrint('\x1B[32m$msg\x1B[0m');
    }
  }

  static void yellow(String msg) {
    if (kDebugMode) {
      debugPrint('\x1B[33m$msg\x1B[0m');
    }
  }

  static void cyan(String msg) {
    if (kDebugMode) {
      debugPrint('\x1B[36m$msg\x1B[0m');
    }
  }

  static void pink(String msg) {
    if (kDebugMode) {
      debugPrint('\x1B[35m$msg\x1B[0m');
    }
  }
}
