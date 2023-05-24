import 'mdx_logger.dart';

abstract class LoggerProvider {
  void call({required String message, required LogTypes type});
}
