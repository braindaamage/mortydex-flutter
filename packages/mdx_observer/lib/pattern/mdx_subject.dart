import 'package:mdx_observer/pattern/mdx_observable.dart';

class MDXSubject<T extends Object> {
  final List<MDXObservable> _observers = [];

  void addObserver(MDXObservable observer) {
    _observers.add(observer);
  }

  void removeObserver(MDXObservable observer) {
    _observers.removeWhere((storedObserver) => storedObserver == observer);
  }

  MDXObservable<T> get asObservable => _MDXSubjectStream(this);

  void next(T newValue) {
    for (final observer in _observers) {
      observer.next(newValue);
    }
  }
}

class _MDXSubjectStream<T extends Object> extends MDXObservable<T> {
  final MDXSubject _subject;

  _MDXSubjectStream(this._subject) {
    _subject.addObserver(this);
  }

  @override
  void cancel() {
    _subject.removeObserver(this);
    super.cancel();
  }
}
