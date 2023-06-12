import 'package:mdx_characters/mdx_characters.dart';

class MDXCharacterRepositoryImp implements MDXCharacterRepository {
  final MDXCharacterCloudDataSource cloudDataSource;

  MDXCharacterRepositoryImp({required this.cloudDataSource});

  @override
  Future<List<MDXCharacter>> getAllCharacters(int page) =>
      cloudDataSource.getAllCharacters(page);

  @override
  Future<MDXCharacter> getCharacterById(int id) =>
      cloudDataSource.getCharacterById(id);

  @override
  Future<List<MDXCharacter>> getCharactersByIds(List<int> ids) =>
      cloudDataSource.getCharactersByIds(ids);

  @override
  Future<List<MDXCharacter>> getFilteredCharacters(MDXCharacterFilter filter) =>
      cloudDataSource.getFilteredCharacters(filter);
}
