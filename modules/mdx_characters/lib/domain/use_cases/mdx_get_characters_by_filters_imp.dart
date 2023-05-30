import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/mdx_core.dart';

class MDXGetFilteredCharactersImp implements MDXGetFilteredCharactersUseCase {
  final MDXCharacterRepository characterRepository;

  MDXGetFilteredCharactersImp({required this.characterRepository});

  @override
  Future<Either<Failure, List<MDXCharacter>>> call(
      MDXCharacterFilter filter) async {
    try {
      final characters =
          await characterRepository.getFilteredCharacters(filter);
      return Right(characters);
    } catch (_) {
      return Left(Failure());
    }
  }
}
