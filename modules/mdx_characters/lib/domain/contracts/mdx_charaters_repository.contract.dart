import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/mdx_core.dart';

abstract interface class MDXCharactersRepositoryProtocol {
  Future<MDXResponse<MDXCharacter, MDXFailure>> getCharacterBy({
    required int id,
  });
  Future<MDXResponse<List<MDXCharacter>, MDXFailure>> getCharactersByPage(
    int page,
  );
  Future<MDXResponse<List<MDXCharacter>, MDXFailure>> getCharactersByListOfIds(
    List<int> ids,
  );
  Future<MDXResponse<List<MDXCharacter>, MDXFailure>> getCharactersByFilters(
    Map<MDXCharacterFilter, String> filter,
  );
}
