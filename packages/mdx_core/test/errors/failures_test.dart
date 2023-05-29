// mdx_core/test/errors/failures_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_core/errors/failures.dart';

void main() {
  group('Failure', () {
    test('should contain the provided error message', () {
      final failure = Failure('Error message');
      expect(failure.message, equals('Error message'));
    });

    test('should contain an empty message when no message is provided', () {
      final failure = Failure();
      expect(failure.message, isEmpty);
    });
  });
}
