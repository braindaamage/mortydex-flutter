import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/mdx_core.dart';

class MDXGetAllCharactersImp implements MDXGetAllCharactersUseCase {
  final MDXCharacterRepository characterRepository;

  MDXGetAllCharactersImp({required this.characterRepository});

  @override
  Future<Either<Failure, List<MDXCharacter>>> call(int page) async {
    try {
      final characters = await characterRepository.getAllCharacters(page);
      return Right(characters);
    } catch (_) {
      return Left(Failure());
    }
  }
}
