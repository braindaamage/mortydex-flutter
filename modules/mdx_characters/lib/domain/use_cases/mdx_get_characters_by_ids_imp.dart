import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/mdx_core.dart';

class MDXGetCharactersByIdsImp implements MDXGetCharactersByIdsUseCase {
  final MDXCharacterRepository characterRepository;

  MDXGetCharactersByIdsImp({required this.characterRepository});

  @override
  Future<Either<Failure, List<MDXCharacter>>> call(List<int> ids) async {
    try {
      final characters = await characterRepository.getCharactersByIds(ids);
      return Right(characters);
    } catch (_) {
      return Left(Failure());
    }
  }
}
