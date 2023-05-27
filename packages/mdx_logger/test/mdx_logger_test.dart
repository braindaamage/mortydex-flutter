import 'package:mdx_logger/logger_provider.dart';
import 'package:mdx_logger/mdx_logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

/// Generate Mock with 'dart run build_runner build'
@GenerateNiceMocks([MockSpec<LoggerProvider>()])
import './mdx_logger_test.mocks.dart';

void main() {
  final mockLoggerProvider = MockLoggerProvider();

  group("Logger", () {
    setUp(() {
      Logger.addProvider(mockLoggerProvider);
    });

    test('should fordware the call to mockLoggerProvider', () {
      // arrange
      const String message = 'Test message';
      // act
      Logger.log(
        message: message,
      );
      // assert
      verify(
        mockLoggerProvider(
          message: message,
          type: LogTypes.info,
        ),
      );
    });
  });
}
