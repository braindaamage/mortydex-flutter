import 'package:mdx_logger/logger_provider.dart';
import 'package:mdx_logger/mdx_logger.dart';

typedef PrintConsole = Function(
  String message, {
  Object? error,
  StackTrace? stackTrace,
});

class ConsoleProvider implements LoggerProvider {
  static const _identifier = '\x1B[34mMDX Logger\x1B[0m';
  final PrintConsole _printConsole;

  ConsoleProvider({required PrintConsole printConsole})
      : _printConsole = printConsole;

  @override
  void call({required String message, required LogTypes type}) {
    switch (type) {
      case LogTypes.warning:
        _printConsole(
          '$_identifier \x1B[32m[${_printWarning(type.toShortString())}\x1B[32m]: $message\x1B[0m',
        );
      case LogTypes.error:
        _printConsole(
          '$_identifier \x1B[32m[${_printError(type.toShortString())}\x1B[32m]: $message\x1B[0m',
        );
      default:
        _printConsole(
          '$_identifier \x1B[32m[${_printInfo(type.toShortString())}\x1B[32m]: $message\x1B[0m',
        );
    }
  }

  String _printInfo(String text) => '\x1B[34m$text\x1B[0m';
  String _printWarning(String text) => '\x1B[33m$text\x1B[0m';
  String _printError(String text) => '\x1B[31m$text\x1B[0m';
}
