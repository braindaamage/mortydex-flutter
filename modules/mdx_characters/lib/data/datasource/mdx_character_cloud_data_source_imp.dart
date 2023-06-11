import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/exceptions/module.dart';
import 'package:mdx_network/mdx_network.dart';

class MDXCharacterCloudDataSourceImp implements MDXCharacterCloudDataSource {
  final MDXNetwork networkClient;

  MDXCharacterCloudDataSourceImp({
    required this.networkClient,
  });

  @override
  Future<List<MDXCharacter>> getAllCharacters(int page) {
    return networkClient.get<List<MDXCharacter>>(Endpoints.characters,
        fromJson: (json) {
      if (json['results'] == null) throw MapperException();
      final list = json['results'] as List<dynamic>;
      return list
          .map((charater) => MDXCharacterDTO.fromJson(charater).toEntity())
          .toList();
    }, queryParams: {
      'page': page.toString(),
    });
  }

  @override
  Future<MDXCharacter> getCharacterById(int id) {
    // TODO: implement getCharacterById
    throw UnimplementedError();
  }

  @override
  Future<List<MDXCharacter>> getCharactersByIds(List<int> ids) {
    // TODO: implement getCharactersByIds
    throw UnimplementedError();
  }

  @override
  Future<List<MDXCharacter>> getFilteredCharacters(MDXCharacterFilter filter) {
    // TODO: implement getFilteredCharacters
    throw UnimplementedError();
  }
}
