import 'package:mdx_observer/mdx_observer.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// ignore: unreachable_from_main
class MockMDXObservable<T extends Object> extends Mock
    implements MDXObservable<T> {}

void main() {
  late MockMDXObservable mockMDXObservable;

  group('BehaviorSubject', () {
    setUp(() {
      mockMDXObservable = MockMDXObservable();
    });

    test('should send first value when no initial value exist', () async {
      // arrange
      const number = 1;
      final subject = BehaviorSubject<int>();
      subject.addObserver(mockMDXObservable);
      // act
      subject.next(number);
      await untilCalled(mockMDXObservable.next(number));
      // assert
      verify(mockMDXObservable.next(number));
      verifyNoMoreInteractions(mockMDXObservable);
    });

    test('should send initial value when add observer', () async {
      // arrange
      const number = 1;
      final subject = BehaviorSubject<int>(number);
      subject.addObserver(mockMDXObservable);
      // act
      await untilCalled(mockMDXObservable.next(number));
      // assert
      verify(mockMDXObservable.next(number));
      verifyNoMoreInteractions(mockMDXObservable);
    });

    test('should send initial value and second value in order', () async {
      // arrange
      const number = 1;
      const number2 = 2;
      final subject = BehaviorSubject<int>(number);
      subject.addObserver(mockMDXObservable);
      // act
      subject.next(number2);
      // assert
      verifyInOrder([
        mockMDXObservable.next(number),
        mockMDXObservable.next(number2),
      ]);
    });
  });
}
