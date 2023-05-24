import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_logger/mdx_logger.dart';
import 'package:mdx_logger/providers/console_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

/// Generate Mock with 'dart run build_runner build'
@GenerateNiceMocks([MockSpec<ConsoleProvider>()])
import './mdx_logger_test.mocks.dart';

void main() {
  final mockConsoleProvider = MockConsoleProvider();

  group("useLogger", () {
    setUp(() {
      Logger.addProvider(mockConsoleProvider);
    });

    test('should fordware the call to mockConsoleProvider', () {
      // arrange
      const String message = 'Test message';
      const LogTypes type = LogTypes.info;
      // act
      Logger.log(message: message, type: type);
      // assert
      verify(mockConsoleProvider(message: message, type: type));
    });
  });
}
