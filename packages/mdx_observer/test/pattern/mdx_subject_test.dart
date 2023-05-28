import 'package:mdx_observer/mdx_observer.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// ignore: unreachable_from_main
class MockMDXObservable<T extends Object> extends Mock
    implements MDXObservable<T> {}

void main() {
  late MockMDXObservable<int> mockMDXObservable;

  setUp(() {
    mockMDXObservable = MockMDXObservable<int>();
  });

  group('MockObservable', () {
    test('should fordware number to next method', () async {
      // arrange
      const number = 1;
      final subject = MDXSubject<int>();
      subject.addObserver(mockMDXObservable);
      // act
      subject.next(number);
      await untilCalled(mockMDXObservable.next(number));
      // assert
      verify(mockMDXObservable.next(number));
    });

    test('should fordware error to onError method', () async {
      // arrange
      final error = Error();
      final subject = MDXSubject<int>();
      subject.addObserver(mockMDXObservable);
      // act
      subject.onError(error);
      await untilCalled(mockMDXObservable.onError(error));
      // assert
      verify(mockMDXObservable.onError(error));
    });

    test('should has no more interaction when remove observable', () async {
      // arrange
      const number = 1;
      final subject = MDXSubject<int>();
      subject.addObserver(mockMDXObservable);
      // act
      subject.next(number);
      await untilCalled(mockMDXObservable.next(number));
      subject.removeObserver(mockMDXObservable);
      subject.next(number);
      // assert
      verify(mockMDXObservable.next(number));
      verifyNoMoreInteractions(mockMDXObservable);
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

    test('should no more interact when cancel observable', () async {
      // arrange
      const number = 1;
      final subject = MDXSubject<int>();
      final observable = subject.asObservable;
      observable.listen(mockMDXObservable.next);
      // act
      subject.next(number);
      await untilCalled(mockMDXObservable.next(number));
      await observable.cancel();
      subject.next(number);
      // assert
      verify(mockMDXObservable.next(number));
      verifyNoMoreInteractions(mockMDXObservable);
    });
  });
}
