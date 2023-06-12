abstract class Either<L, R> {
  const Either();

  T fold<T>(T Function(L l) leftF, T Function(R r) rightF);

  bool get isLeft;
  bool get isRight;

  L get left;
  R get right;
}

class Left<L, R> extends Either<L, R> {
  final L value;

  Left(this.value);

  @override
  T fold<T>(T Function(L l) leftF, T Function(R r) rightF) => leftF(value);

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;

  @override
  L get left => value;

  @override
  R get right => throw Exception('Tried to get right value from Left');
}

class Right<L, R> extends Either<L, R> {
  final R value;

  Right(this.value);

  @override
  T fold<T>(T Function(L l) leftF, T Function(R r) rightF) => rightF(value);

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;

  @override
  L get left => throw Exception('Tried to get left value from Right');

  @override
  R get right => value;
}
