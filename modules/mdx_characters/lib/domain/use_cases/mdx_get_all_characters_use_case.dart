import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/mdx_core.dart';

abstract interface class MDXGetAllCharactersUseCase {
  Future<Either<Failure, List<MDXCharacter>>> call(int page);
}
