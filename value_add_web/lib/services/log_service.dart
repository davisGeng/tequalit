import 'package:flutter/foundation.dart';





class Log {
  static void t(dynamic message) {
    print(message);

  }

  static void d(dynamic message) {
    print(message);

  }

  static void i(dynamic message) {
    print(message);
  }

  static void w(dynamic message) {
    print(message);
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    print(message);
  }
}
