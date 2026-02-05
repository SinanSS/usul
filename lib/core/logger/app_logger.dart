import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// A wrapper around the Logger package to provide a consistent logging interface throughout the app.
class AppLogger {
  late final Logger _logger;

  AppLogger() {
    _logger = Logger(
      level: kDebugMode ? Level.debug : Level.warning,
      filter: ProductionFilter(),
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
    );
  }

  void t(dynamic message) {
    _logger.t(message);
  }

  void d(dynamic message) {
    _logger.d(message);
  }

  void i(dynamic message) {
    _logger.i(message);
  }

  void w(dynamic message) {
    _logger.w(message);
  }

  void e(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  void f(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}
