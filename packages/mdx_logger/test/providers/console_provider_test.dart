import 'package:mdx_logger/mdx_logger.dart';
import 'package:mdx_logger/providers/console_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

/// Generate Mock with 'dart run build_runner build'
@GenerateNiceMocks([MockSpec<TestPrintConsole>()])
import './console_provider_test.mocks.dart';

// ignore: unreachable_from_main
class TestPrintConsole {
  void printConsole(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {}
}

void main() {
  late MockTestPrintConsole mockPrintConsole;

  group('ConsoleProvider', () {
    setUp(() {
      mockPrintConsole = MockTestPrintConsole();
    });

    test('should fordware the call to mockPrintConsole when type is info', () {
      // arrange
      final ConsoleProvider consoleProvider =
          ConsoleProvider(printConsole: mockPrintConsole.printConsole);
      const String message = 'Test Message';
      // act
      consoleProvider(message: message, type: LogTypes.info);
      // assert
      verify(mockPrintConsole.printConsole(argThat(contains(message))));
    });

    test('should fordware the call to mockPrintConsole when type is warning',
        () {
      // arrange
      final ConsoleProvider consoleProvider =
          ConsoleProvider(printConsole: mockPrintConsole.printConsole);
      const String message = 'Test Message';
      // act
      consoleProvider(message: message, type: LogTypes.warning);
      // assert
      verify(mockPrintConsole.printConsole(argThat(contains(message))));
    });

    test('should fordware the call to mockPrintConsole when type is error', () {
      // arrange
      final ConsoleProvider consoleProvider =
          ConsoleProvider(printConsole: mockPrintConsole.printConsole);
      const String message = 'Test Message';
      // act
      consoleProvider(message: message, type: LogTypes.error);
      // assert
      verify(mockPrintConsole.printConsole(argThat(contains(message))));
    });
  });
}
