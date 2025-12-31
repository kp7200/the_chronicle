import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

var logger = MyLogger();

class LogColor {
  static const reset = '\x1B[0m';
  static const verbose = '\x1B[90m'; // grey
  static const debug = '\x1B[36m';   // cyan
  static const info = '\x1B[32m';    // green
  static const warning = '\x1B[33m'; // yellow
  static const error = '\x1B[31m';   // red
}

class MyLogger {
  /// Log a message at level verbose.
  void v(dynamic message) {
    _print("${LogColor.verbose} VERBOSE: $message${LogColor.reset}");
  }

  /// Log a message at level debug.
  void d(dynamic message) {
    _print("${LogColor.debug} DEBUG: $message${LogColor.reset}");
  }

  /// Log a message at level info.
  void i(dynamic message) {
    _print("${LogColor.info} INFO: $message${LogColor.reset}");
  }

  /// Log a message at level warning.
  void w(dynamic message) {
    _print("${LogColor.warning} WARNING: $message${LogColor.reset}");
  }

  /// Log a message at level error.
  void e(dynamic message) {
    _print("${LogColor.error} ERROR: $message${LogColor.reset}");
  }

  void _print(dynamic message) {
    if (kDebugMode) {
      print("$message");
    }
  }

  void _log(dynamic message) {
    if (kDebugMode) {
      developer.log("$message");
    }
  }

  void log(dynamic message, {bool printFullText = false,}) {
    if (printFullText) {
      _log(message);
    } else {
      _print(message);
    }
    // if (stackTrace != null) {
    //   _print(stackTrace);
    // }
  }
}
