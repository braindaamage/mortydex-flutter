import 'logger_provider.dart';

class Logger {
  static final _Logger _logger = _Logger();

  static void log({required String message, LogTypes type = LogTypes.info}) {
    _logger.log(message: message, type: type);
  }

  static void addProvider(LoggerProvider provider) {
    _logger.addProvider(provider);
  }
}

class _Logger {
  final Set<LoggerProvider> _providers = {};

  void log({required String message, required LogTypes type}) {
    for (var provider in _providers) {
      provider(message: message, type: type);
    }
  }

  void addProvider(LoggerProvider provider) {
    _providers.add(provider);
  }
}

enum LogTypes {
  info,
  warning,
  error,
}

extension ToString on LogTypes {
  String toShortString() => toString().split('.').last.toUpperCase();
}
