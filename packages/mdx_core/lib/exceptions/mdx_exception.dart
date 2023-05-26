class MDXException implements Exception {
  final dynamic _message;
  MDXException(this._message);

  @override
  String toString() {
    if (_message == null) return runtimeType.toString();
    return _message;
  }
}

// class _MDXException implements MDXException {
//   final dynamic message;
//   _MDXException([this.message]);

//   @override
//   String toString() {
//     final name = runtimeType.toString();
//     if (message == null) return name;
//     return '$name: $message}';
//   }
// }
