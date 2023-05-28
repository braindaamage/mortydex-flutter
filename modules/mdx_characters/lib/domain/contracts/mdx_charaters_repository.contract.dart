import 'package:mdx_characters/mdx_characters.dart';

abstract interface class MDXCharactersRepositoryProtocol {
  Future<MDXCharacter> getCharacterBy({required int id});
  Future<List<MDXCharacter>> getCharactersByPage(int page);
  Future<List<MDXCharacter>> getCharactersByListOfIds(List<int> ids);
  Future<List<MDXCharacter>> getCharactersByFilters(
      Map<MDXCharacterFilter, String> filter);
}
