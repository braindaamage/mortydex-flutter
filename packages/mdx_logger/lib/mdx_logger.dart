import 'logger_provider.dart';
import 'providers/console_provider.dart';

class Logger {
  static final _providers = <LoggerProvider>{
    ConsoleProvider(),
  };

  static void log({required String message, LogTypes type = LogTypes.log}) {
    for (var provider in _providers) {
      provider(message: message, type: type);
    }
  }
}

enum LogTypes {
  log,
  warning,
  error,
}

extension ToString on LogTypes {
  String toShortString() => toString().split('.').last.toUpperCase();
}
