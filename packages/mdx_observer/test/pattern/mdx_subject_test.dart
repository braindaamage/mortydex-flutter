import 'package:mdx_observer/mdx_observer.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import './mdx_observable_test.mocks.dart';

void main() {
  late MockFakeClass<int> mockFakeClass;

  setUp(() {
    mockFakeClass = MockFakeClass<int>();
  });

  group('Listener', () {
    test('should fordware number to next method', () async {
      // arrange
      const number = 1;
      final subject = MDXSubject<int>();
      subject.asObservable.listen(mockFakeClass.fakeOnDone);
      // act
      subject.next(number);
      await untilCalled(mockFakeClass.fakeOnDone(number));
      // assert
      verify(mockFakeClass.fakeOnDone(number));
    });

    test('should fordware error to onError method', () async {
      // arrange
      final error = Error();
      final subject = MDXSubject<int>();
      subject.asObservable
          .listen(mockFakeClass.fakeOnDone, onError: mockFakeClass.fakeOnError);
      // act
      subject.onError(error);
      await untilCalled(mockFakeClass.fakeOnError(error));
      // assert
      verify(mockFakeClass.fakeOnError(error));
    });

    test('should has no more interaction when remove listener', () async {
      // arrange
      const number = 1;
      final subject = MDXSubject<int>();
      final listener = subject.asObservable.listen(mockFakeClass.fakeOnDone);
      // act
      subject.next(number);
      await untilCalled(mockFakeClass.fakeOnDone(number));
      await listener.cancel();
      subject.next(number);
      // assert
      verify(mockFakeClass.fakeOnDone(number));
      verifyNoMoreInteractions(mockFakeClass);
    });
  });

  group('asObservable', () {
    test('should return a MDXObservable instance', () {
      // arrange
      final subject = MDXSubject<int>();
      final observable = subject.asObservable;
      // assert
      expect(observable, isA<MDXObservable>());
    });

    test('should throwing exception when call next on disposed subject',
        () async {
      // arrange
      const number = 1;
      final subject = MDXSubject<int>();
      subject.asObservable.listen(mockFakeClass.fakeOnDone);
      // act
      subject.next(number);
      await untilCalled(mockFakeClass.fakeOnDone(number));
      await subject.dispose();
      // assert
      verify(mockFakeClass.fakeOnDone(number));
      verifyNoMoreInteractions(mockFakeClass);
      expect(() => subject.next(number), throwsStateError);
    });
  });
}
