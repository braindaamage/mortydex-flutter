import 'package:mdx_observer/pattern/mdx_observable.dart';

class MDXSubject<T extends Object> {
  final MDXObservable<T> _observable = MDXObservable<T>();

  MDXObservable<T> get asObservable => _observable;

  void next(T newValue) {
    _observable.next(newValue);
  }

  void onError(Object error, [StackTrace? stackTrace]) {
    _observable.onError(error, stackTrace);
  }

  Future<void> dispose() async {
    await _observable.close();
  }
}
