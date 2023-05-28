import 'package:mdx_observer/pattern/mdx_observable.dart';
import 'package:mdx_observer/pattern/mdx_subject.dart';

class BehaviorSubject<T extends Object> extends MDXSubject<T> {
  T? storedValue;

  BehaviorSubject(this.storedValue);

  @override
  void addObserver(MDXObservable<Object> observer) {
    super.addObserver(observer);
    if (storedValue != null) observer.next(storedValue!);
  }

  @override
  void next(T newValue) {
    storedValue = newValue;
    super.next(newValue);
  }
}
