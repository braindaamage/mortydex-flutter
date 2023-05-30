import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/mdx_core.dart';

abstract interface class MDXGetCharactersByIdsUseCase {
  Future<Either<Failure, List<MDXCharacter>>> call(List<int> ids);
}
