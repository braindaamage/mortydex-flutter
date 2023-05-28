import 'dart:async';

class MDXObservable<T extends Object> {
  final List<_MDXListener<T>> _listeners = [];

  final StreamController<T> _streamController = StreamController.broadcast();

  bool get hasClosed => _streamController.isClosed;

  void next(T newValue) => _streamController.add(newValue);

  void onError(Object error, [StackTrace? stackTrace]) =>
      _streamController.addError(
        error,
        stackTrace,
      );

  MDXListener listen(
    void Function(T value)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    final listener = _MDXListener(
      this,
      _streamController.stream.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      ),
    );
    _listeners.add(listener);
    return listener;
  }

  void removeListener(MDXListener listener) {
    _listeners.removeWhere((storedListener) => storedListener == listener);
  }

  Future<void> cancelAll() async {
    for (final listener in _listeners) {
      await listener.cancelFromObservable();
    }
    _listeners.clear();
  }

  Future<void> close() async {
    await _streamController.close();
  }
}

abstract class MDXListener<T extends Object> {
  final MDXObservable _observable;
  final StreamSubscription<T> _listener;

  MDXListener(this._observable, this._listener);

  Future<void> cancel() async {
    _observable.removeListener(this);
    await _listener.cancel();
  }
}

class _MDXListener<T extends Object> extends MDXListener<T> {
  _MDXListener(super.observable, super.listener);

  Future<void> cancelFromObservable() async {
    await _listener.cancel();
  }
}
