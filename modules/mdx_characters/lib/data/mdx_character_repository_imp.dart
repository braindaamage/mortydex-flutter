import 'package:mdx_characters/mdx_characters.dart';

class MDXCharacterRepositoryImp implements MDXCharacterRepository {
  final MDXCharacterDataSource dataSource;

  MDXCharacterRepositoryImp({required this.dataSource});

  @override
  Future<List<MDXCharacter>> getAllCharacters(int page) =>
      dataSource.getAllCharacters(page);

  @override
  Future<MDXCharacter> getCharacterById(int id) =>
      dataSource.getCharacterById(id);

  @override
  Future<List<MDXCharacter>> getCharactersByIds(List<int> ids) =>
      dataSource.getCharactersByIds(ids);

  @override
  Future<List<MDXCharacter>> getFilteredCharacters(MDXCharacterFilter filter) =>
      dataSource.getFilteredCharacters(filter);
}
