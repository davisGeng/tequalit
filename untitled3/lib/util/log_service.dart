import 'package:logger/logger.dart';
import 'package:get/get.dart';

class LogService extends GetxService {
  late final Logger logger = Logger(
    output: MultiOutput([]),
    filter: AlwaysOnFilter(),
    level: Level.debug,
    printer: PrettyPrinter(
      stackTraceBeginIndex: 2,
      methodCount: 8,
      colors: false,
    ),
  );
  late final String logPath;
  final int maxFiles = 5;
  final int maxFileSize = 1024000;

  void trace(String message) {
    logger.d(message);
  }

  void debug(String message) {
    logger.d(message);
  }

  void info(String message) {
    logger.i(message);
  }

  void warn(String message) {
    logger.w(message);
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.e(message, error: error, stackTrace: stackTrace);
  }
}

class Log {
  static void t(dynamic message) {
    Get.find<LogService>().trace(message.toString());
  }

  static void d(dynamic message) {
    Get.find<LogService>().debug(message.toString());
  }

  static void i(dynamic message) {
    Get.find<LogService>().info(message.toString());
  }

  static void w(dynamic message) {
    Get.find<LogService>().warn(message.toString());
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    Get.find<LogService>().error(message.toString(), error, stackTrace);
  }
}

class AlwaysOnFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}
