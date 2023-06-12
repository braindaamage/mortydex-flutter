import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_core/utils/either.dart';

void main() {
  group('Either', () {
    group('Left', () {
      test('should return value when fold is called with left function', () {
        final either = Left('left');
        final result = either.fold((l) => l, (r) => 'right');
        expect(either.left, equals('left'));
        expect(result, equals('left'));
      });

      test('should throw an exception when trying to access right value', () {
        final either = Left('left');
        expect(() => either.right, throwsA(isA<Exception>()));
      });

      test('should return true when checking if isLeft', () {
        final either = Left('left');
        expect(either.isLeft, isTrue);
      });

      test('should return false when checking if isRight', () {
        final either = Left('left');
        expect(either.isRight, isFalse);
      });
    });

    group('Right', () {
      test('should return value when fold is called with right function', () {
        final either = Right('right');
        final result = either.fold((l) => 'left', (r) => r);
        expect(either.right, equals('right'));
        expect(result, equals('right'));
      });

      test('should throw an exception when trying to access left value', () {
        final either = Right('right');
        expect(() => either.left, throwsA(isA<Exception>()));
      });

      test('should return true when checking if isRight', () {
        final either = Right('right');
        expect(either.isRight, isTrue);
      });

      test('should return false when checking if isLeft', () {
        final either = Right('right');
        expect(either.isLeft, isFalse);
      });
    });
  });
}
