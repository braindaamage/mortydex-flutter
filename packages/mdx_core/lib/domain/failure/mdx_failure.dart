import 'package:equatable/equatable.dart';

abstract class MDXFailure extends Equatable {
  @override
  List<Object> get props => [];
}

// general failures

class ServerFailure extends MDXFailure {}

class CacheFailure extends MDXFailure {}
