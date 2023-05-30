import 'package:mdx_characters/mdx_characters.dart';

abstract interface class MDXCharacterRepository {
  Future<List<MDXCharacter>> getAllCharacters(int page);
  Future<MDXCharacter> getCharacterById(int id);
  Future<List<MDXCharacter>> getCharactersByIds(List<int> ids);
  Future<List<MDXCharacter>> getFilteredCharacters(MDXCharacterFilter filter);
}
