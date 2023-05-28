enum MDXResponseType {
  success,
  fail,
}

class MDXResponseTypeException implements Exception {}

class MDXResponse<Model extends Object, Failure extends Object> {
  final Model? _model;
  final Failure? _failure;
  final MDXResponseType _type;

  MDXResponse._(this._type, {Model? model, Failure? failure})
      : _model = model,
        _failure = failure;

  factory MDXResponse.success(Model model) =>
      MDXResponse._(MDXResponseType.success, model: model);

  factory MDXResponse.fail(Failure failure) =>
      MDXResponse._(MDXResponseType.fail, failure: failure);

  MDXResponseType get responseType => _type;

  Model get successResponse => _type == MDXResponseType.success
      ? _model!
      : throw MDXResponseTypeException;

  Failure get failResponse => _type == MDXResponseType.fail
      ? _failure!
      : throw MDXResponseTypeException;
}
