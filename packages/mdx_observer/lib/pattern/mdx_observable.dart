import 'dart:async';

class MDXObservable<T extends Object> {
  StreamSubscription<T>? _listener;

  final StreamController<T> _streamController = StreamController.broadcast();

  Stream<T> get stream => _streamController.stream;

  void next(T newValue) => _streamController.add(newValue);

  void onError(Object error, [StackTrace? stackTrace]) =>
      _streamController.addError(
        error,
        stackTrace,
      );

  void listen(
    void Function(T value)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    _listener = _streamController.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  Future<void>? cancel() => _listener?.cancel();
}
