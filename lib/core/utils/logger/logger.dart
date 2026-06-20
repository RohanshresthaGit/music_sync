// import 'package:flutter/foundation.dart';

// /// Log levels in ascending severity.
// enum LogLevel { verbose, debug, info, warning, error }

// /// A single log record.
// class _LogEntry {
//   final LogLevel level;
//   final String tag;
//   final String message;
//   final Object? error;
//   final StackTrace? stackTrace;
//   final DateTime timestamp;

//   _LogEntry(this.level, this.tag, this.message, this.error, this.stackTrace)
//       : timestamp = DateTime.now();
// }

// /// Production-safe logger.
// ///
// /// - In **release** builds: every call is a compile-time no-op.
// ///   `kReleaseMode` is a Dart compile-time constant, so the compiler
// ///   tree-shakes all log code out of the binary. Zero strings, zero tags,
// ///   zero stack traces survive in the APK / IPA.
// /// - In **debug / profile** builds: coloured console output + an in-memory
// ///   ring buffer (capped at [_kMaxBuffer] entries) for the overlay.
// class AppLogger {
//   AppLogger._();

//   // ── configuration ──────────────────────────────────────────────────────────

//   static const int _kMaxBuffer = 300;
//   static LogLevel _minLevel = LogLevel.verbose;

//   /// Change the minimum level that gets printed (debug/profile only).
//   static void setMinLevel(LogLevel level) {
//     if (!kReleaseMode) _minLevel = level;
//   }

//   // ── public API ─────────────────────────────────────────────────────────────

//   static void v(String tag, String msg) =>
//       _emit(LogLevel.verbose, tag, msg);

//   static void d(String tag, String msg) =>
//       _emit(LogLevel.debug, tag, msg);

//   static void i(String tag, String msg) =>
//       _emit(LogLevel.info, tag, msg);

//   static void w(String tag, String msg, [Object? err, StackTrace? st]) =>
//       _emit(LogLevel.warning, tag, msg, err, st);

//   static void e(String tag, String msg, [Object? err, StackTrace? st]) =>
//       _emit(LogLevel.error, tag, msg, err, st);

//   // ── in-memory buffer (debug overlay) ───────────────────────────────────────

//   static final List<_LogEntry> _buffer = [];

//   /// Unmodifiable snapshot for a debug overlay or log screen.
//   static List<_LogEntry> get entries => List.unmodifiable(_buffer);

//   static void clear() {
//     if (!kReleaseMode) _buffer.clear();
//   }

//   // ── core ───────────────────────────────────────────────────────────────────

//   static void _emit(
//     LogLevel level,
//     String tag,
//     String message, [
//     Object? error,
//     StackTrace? stackTrace,
//   ]) {
//     // ✅ SECURITY: kReleaseMode is a compile-time constant.
//     // The Dart compiler evaluates this at build time — in a release build
//     // this becomes `if (true) return;` and the entire method body is
//     // dead code. The tree shaker removes it completely from the binary.
//     // No log strings, tag names, or stack traces are ever shipped to users.
//     if (kReleaseMode) return;

//     if (level.index < _minLevel.index) return;

//     final entry = _LogEntry(level, tag, message, error, stackTrace);

//     _buffer.add(entry);
//     if (_buffer.length > _kMaxBuffer) _buffer.removeAt(0);

//     _printToConsole(entry);
//   }

//   // ── console formatting ─────────────────────────────────────────────────────

//   static void _printToConsole(_LogEntry e) {
//     // ANSI colour codes — visible in Android Studio, VS Code, terminal.
//     const r = '\x1B[0m';       // reset
//     const bold = '\x1B[1m';
//     const grey = '\x1B[90m';
//     const cyan = '\x1B[96m';
//     const green = '\x1B[92m';
//     const yellow = '\x1B[93m';
//     const red = '\x1B[91m';
//     const bgRed = '\x1B[41m';
//     const white = '\x1B[97m';

//     final (icon, color, label) = switch (e.level) {
//       LogLevel.verbose => ('·',  grey,   'VERBOSE'),
//       LogLevel.debug   => ('◉',  cyan,   'DEBUG  '),
//       LogLevel.info    => ('✔',  green,  'INFO   '),
//       LogLevel.warning => ('⚠',  yellow, 'WARN   '),
//       LogLevel.error   => ('✖',  red,    'ERROR  '),
//     };

//     final time = _ts(e.timestamp);
//     final divider = '─' * 56;

//     if (e.level.index >= LogLevel.error.index) {
//       debugPrint('$red┌$divider$r');
//       debugPrint('$red│$r $bgRed$white$bold ERROR $r  '
//           '$grey$time$r  $bold[${e.tag}]$r');
//       debugPrint('$red│$r  ${e.message}');
//       if (e.error != null) {
//         debugPrint('$red│$r  $yellow${e.error}$r');
//       }
//       if (e.stackTrace != null) {
//         for (final line
//             in e.stackTrace.toString().trimRight().split('\n').take(8)) {
//           debugPrint('$red│$r  $grey$line$r');
//         }
//       }
//       debugPrint('$red└$divider$r');
//     } else {
//       debugPrint(
//         '$color$icon$r '
//         '$grey$time$r '
//         '$bold$color$label$r '
//         '$grey[${e.tag}]$r '
//         '${e.message}',
//       );
//     }
//   }

//   static String _ts(DateTime t) =>
//       '${_p(t.hour)}:${_p(t.minute)}:${_p(t.second)}.${t.millisecond.toString().padLeft(3, '0')}';

//   static String _p(int n) => n.toString().padLeft(2, '0');
// }

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';


/// A production-safe singleton logger built on top of the `logger` package.
///
/// This logger provides:
/// - Pretty console output (colors, emojis, timestamps)
/// - Multiple log levels (debug, info, warning, error, verbose, fatal)
/// - In-memory log buffering for debugging purposes
/// - Centralized logging across the entire app
///
/// ---
///
/// ## 🔥 Build Behavior
///
/// - **Debug/Profile mode**
///   - Logs are printed to console
///   - Logs are stored in an in-memory buffer (max ~300 entries recommended by usage)
///   - Useful for debugging and inspecting runtime behavior
///
/// - **Release mode**
///   - Logging calls should ideally be stripped or minimized by compiler optimizations
///   - No sensitive or verbose logs should be included in production builds
///
/// ---
///
/// ## 📦 Features
///
/// ✔ Singleton instance (global access via `AppLogger()`)
/// ✔ Structured logs with levels:
///    - debug
///    - info
///    - warning
///    - error
///    - verbose (trace)
///    - fatal (wtf)
/// ✔ Error + StackTrace support
/// ✔ In-memory log history (for debugging tools / support screens)
///
/// ---
///
/// ## 🚀 Usage
///
/// ```dart
/// final logger = AppLogger();
///
/// logger.debug('Auth', 'User clicked login button');
///
/// logger.info('Auth', 'Login request sent');
///
/// logger.warning('Auth', 'Token is near expiry');
///
/// logger.error('Auth', 'Login failed', error, stackTrace);
///
/// logger.verbose('Network', 'Request payload logged');
/// ```
///
/// ---
///
/// ## 📥 Retrieve Logs
///
/// You can fetch all stored logs for debugging:
///
/// ```dart
/// String logs = AppLogger().getLogs();
/// ```
///
/// Useful for:
/// - Debug screens
/// - Bug reporting
/// - Support diagnostics
///
/// ---
///
/// ## ⚠️ Notes
///
/// - Avoid logging sensitive data (passwords, tokens)
/// - Use `error()` for exceptions and failures
/// - Use `debug()` for development-only tracing
/// - Consider clearing buffer if memory usage becomes large
class AppLogger {
  static final AppLogger _instance = AppLogger._internal();

  factory AppLogger() {
    return _instance;
  }

  AppLogger._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 5,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart),
    );
  }

  late final Logger _logger;
  final StringBuffer _logBuffer = StringBuffer();

  void _logToBuffer(String level, String message,
      [dynamic error, StackTrace? stackTrace]) {
    _logBuffer.writeln('${DateTime.now()}: $level - $message');
    if (error != null) {
      _logBuffer.writeln('Error: $error');
    }
    if (stackTrace != null) {
      _logBuffer.writeln('StackTrace: $stackTrace');
    }
  }

  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logToBuffer('DEBUG', message, error, stackTrace);
    _logger.d(message, error:error, stackTrace: stackTrace);
  }

  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logToBuffer('INFO', message, error, stackTrace);
    _logger.i(message, error:error, stackTrace: stackTrace);
  }

  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logToBuffer('WARNING', message, error, stackTrace);
    _logger.w(message, error:error, stackTrace: stackTrace);
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logToBuffer('ERROR', message, error, stackTrace);
    _logger.e(message, error:error, stackTrace: stackTrace);
  }

  void verbose(String message, [dynamic error, StackTrace? stackTrace]) {
    _logToBuffer('TRACE', message, error, stackTrace);
    _logger.t(message, error:error, stackTrace: stackTrace);
  }

  void wtf(String message, [dynamic error, StackTrace? stackTrace]) {
    _logToBuffer('FATAL', message, error, stackTrace);
    _logger.f(message, error:error, stackTrace: stackTrace);
  }

  void print(String message, [dynamic error, StackTrace? stackTrace]) {
    debugPrint(message);
  }

  String getLogs() {
    return _logBuffer.toString();
  }
}
