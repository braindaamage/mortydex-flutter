import 'logger_provider.dart';
import './providers/console_provider.dart';

part 'mdx_logger_imp.dart';

abstract class Logger {
  static final Logger _instance = _Logger([ConsoleProvider()]);
  void _log({required String message, required LogTypes type});
  void _addProvider(LoggerProvider provider);
  static void log({required String message, LogTypes type = LogTypes.info}) {
    _instance._log(message: message, type: type);
  }

  static void addProvider(LoggerProvider provider) {
    _instance._addProvider(provider);
  }
}
