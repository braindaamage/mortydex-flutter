import 'dart:async';

class MDXObservable<T extends Object> {
  StreamSubscription<T>? _listener;

  final StreamController<T> _streamController = StreamController.broadcast();

  Stream<T> get stream => _streamController.stream;

  void next(T newValue) => _streamController.add(newValue);

  void listen(void Function(T value)? onData) {
    _listener = _streamController.stream.listen(onData);
  }

  void cancel() {
    _listener?.cancel();
  }
}
