part of 'mdx_logger.dart';

enum LogTypes {
  info,
  warning,
  error,
}

extension ToString on LogTypes {
  String toShortString() => toString().split('.').last.toUpperCase();
}

class _Logger implements Logger {
  final Set<LoggerProvider> _providers = {};

  _Logger(List<LoggerProvider> providers) {
    for (final provider in providers) {
      _addProvider(provider);
    }
  }

  @override
  void _log({required String message, required LogTypes type}) {
    for (final provider in _providers) {
      provider(message: message, type: type);
    }
  }

  @override
  void _addProvider(LoggerProvider provider) {
    _providers.add(provider);
  }
}
