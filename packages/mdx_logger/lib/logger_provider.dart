import 'package:mdx_logger/mdx_logger.dart';

abstract class LoggerProvider {
  void call({required String message, required LogTypes type});
}
