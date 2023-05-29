import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/mdx_core.dart';

abstract interface class MDXGetCharacterByIdUseCase {
  Future<Either<Failure, MDXCharacter>> call(int id);
}
