import 'dart:developer' as developer;

import '../mdx_logger.dart';
import '../logger_provider.dart';

class ConsoleProvider implements LoggerProvider {
  static const _identifier = '\x1B[34mMDX Logger\x1B[0m';

  @override
  void call({required String message, required LogTypes type}) {
    switch (type) {
      case LogTypes.warning:
        developer.log(
            '$_identifier \x1B[32m[${_printWarning(type.toShortString())}\x1B[32m]: $message\x1B[0m');
        break;
      case LogTypes.error:
        developer.log(
            '$_identifier \x1B[32m[${_printError(type.toShortString())}\x1B[32m]: $message\x1B[0m');
        break;
      default:
        developer.log(
            '$_identifier \x1B[32m[${_printInfo(type.toShortString())}\x1B[32m]: $message\x1B[0m');
    }
  }

  String _printInfo(String text) => '\x1B[34m$text\x1B[0m';
  String _printWarning(String text) => '\x1B[33m$text\x1B[0m';
  String _printError(String text) => '\x1B[31m$text\x1B[0m';
}
