import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/mdx_core.dart';

class MDXGetCharacterByIdImp implements MDXGetCharacterByIdUseCase {
  final MDXCharacterRepository characterRepository;

  MDXGetCharacterByIdImp({required this.characterRepository});

  @override
  Future<Either<Failure, MDXCharacter>> call(int id) async {
    try {
      final character = await characterRepository.getCharacterById(id);
      return Right(character);
    } catch (_) {
      return Left(Failure());
    }
  }
}
