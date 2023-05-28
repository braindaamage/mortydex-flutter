import 'package:mdx_observer/pattern/mdx_observable.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

/// Generate Mock with 'dart run build_runner build'
@GenerateNiceMocks([MockSpec<FakeClass>()])
import './mdx_observable_test.mocks.dart';

// ignore: unreachable_from_main
abstract interface class FakeClass<T> {
  void fakeOnDone(T value);
  void fakeOnError(Object error);
}

void main() {
  late MockFakeClass mockFakeClass;

  group('MDXObservable', () {
    setUp(() {
      mockFakeClass = MockFakeClass();
    });

    test('should call fakeOnDone with the number when next method is called',
        () async {
      // arrange
      const number = 1;
      final MDXObservable<int> observable = MDXObservable();
      observable.listen(mockFakeClass.fakeOnDone);
      // act
      observable.next(number);
      await untilCalled(mockFakeClass.fakeOnDone(any));
      // assert
      verify(mockFakeClass.fakeOnDone(number));
    });

    test('should call fakeOnError with the error when onError method is called',
        () async {
      // arrange
      final error = Error();
      final MDXObservable<int> observable = MDXObservable();
      observable.listen(
        mockFakeClass.fakeOnDone,
        onError: mockFakeClass.fakeOnError,
      );
      // act
      observable.onError(error);
      await untilCalled(mockFakeClass.fakeOnError(error));
      // assert
      verify(mockFakeClass.fakeOnError(error));
    });

    test('should no more interaction when cancel listener', () async {
      // arrange
      const number = 1;
      final MDXObservable<int> observable = MDXObservable();
      observable.listen(mockFakeClass.fakeOnDone);
      final mockFakeClass2 = MockFakeClass();
      // act
      observable.next(number);
      await untilCalled(mockFakeClass.fakeOnDone(any));
      await observable.cancel();
      observable.listen(mockFakeClass2.fakeOnDone);
      observable.next(number);
      await untilCalled(mockFakeClass2.fakeOnDone(any));
      // assert
      verify(mockFakeClass.fakeOnDone(number));
      verify(mockFakeClass2.fakeOnDone(number));
      verifyNoMoreInteractions(mockFakeClass);
    });
  });
}
