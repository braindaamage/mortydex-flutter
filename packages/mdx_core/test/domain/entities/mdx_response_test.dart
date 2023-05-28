import 'package:mdx_core/mdx_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockModel extends Mock {}

class MockServerFailure extends Mock {}

void main() {
  group('MDXResponse', () {
    late MDXResponse<MockModel, MockServerFailure> response;
    group('Success', () {
      late MockModel mockModel;
      setUp(() {
        mockModel = MockModel();
        response = MDXResponse.success(mockModel);
      });
      test('should get MockModel by success constructor', () {
        // assert
        expect(response.successResponse, mockModel);
      });

      test('should throw MDXResponseTypeException when try get failure', () {
        // assert
        expect(() => response.failResponse, throwsA(MDXResponseTypeException));
      });
    });

    group('Success', () {
      late MockServerFailure mockServerFailure;
      setUp(() {
        mockServerFailure = MockServerFailure();
        response = MDXResponse.fail(mockServerFailure);
      });
      test('should get ServerFailure by fail constructor', () {
        // assert
        expect(response.failResponse, mockServerFailure);
      });

      test('should throw MDXResponseTypeException when try get success', () {
        // assert
        expect(
            () => response.successResponse, throwsA(MDXResponseTypeException));
      });
    });
  });
}
