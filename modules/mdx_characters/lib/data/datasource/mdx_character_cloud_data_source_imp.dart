import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/exceptions/module.dart';
import 'package:mdx_network/mdx_network.dart';

class MDXCharacterCloudDataSourceImp implements MDXCharacterCloudDataSource {
  final MDXNetwork networkClient;

  MDXCharacterCloudDataSourceImp({
    required this.networkClient,
  });

  @override
  Future<List<MDXCharacter>> getAllCharacters(int page) =>
      networkClient.get<List<MDXCharacter>>(
        Endpoints.characters,
        fromJson: (json) {
          if (json['results'] == null) throw MapperException();
          final list = json['results'] as List<dynamic>;
          return list
              .map((charater) => MDXCharacterDTO.fromJson(charater).toEntity())
              .toList();
        },
        queryParams: {
          'page': page.toString(),
        },
      );

  @override
  Future<MDXCharacter> getCharacterById(int id) => networkClient.get(
        Endpoints.character,
        fromJson: (json) => MDXCharacterDTO.fromJson(json).toEntity(),
        param: id.toString(),
      );

  @override
  Future<List<MDXCharacter>> getCharactersByIds(List<int> ids) =>
      networkClient.get(
        Endpoints.charactersByIds,
        fromJsonList: (jsonList) => jsonList
            .map((jsonCharacter) =>
                MDXCharacterDTO.fromJson(jsonCharacter).toEntity())
            .toList(),
        param: ids.join(','),
      );
  @override
  Future<List<MDXCharacter>> getFilteredCharacters(MDXCharacterFilter filter) =>
      networkClient.get(
        Endpoints.charactersFilter,
        fromJson: (json) {
          if (json['results'] == null) return [];
          final list = json['results'] as List<dynamic>;
          return list
              .map((charater) => MDXCharacterDTO.fromJson(charater).toEntity())
              .toList();
        },
        queryParams: MDXCharacterFilterDTO.fromEntity(filter).toQueryParams(),
      );
}
