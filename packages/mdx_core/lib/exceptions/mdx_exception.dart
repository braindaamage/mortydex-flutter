class MDXException implements Exception {
  final dynamic _message;
  MDXException(this._message);

  @override
  String toString() {
    if (_message == null) return runtimeType.toString();
    return _message;
  }
}
