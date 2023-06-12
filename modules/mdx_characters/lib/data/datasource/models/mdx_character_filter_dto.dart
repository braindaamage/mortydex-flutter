import 'package:mdx_characters/mdx_characters.dart';

class MDXCharacterFilterDTO extends MDXCharacterFilter {
  const MDXCharacterFilterDTO({
    super.name,
    super.status,
    super.species,
    super.type,
    super.gender,
  });

  factory MDXCharacterFilterDTO.fromEntity(MDXCharacterFilter entity) =>
      MDXCharacterFilterDTO(
        name: entity.name,
        status: entity.status,
        species: entity.species,
        type: entity.type,
        gender: entity.gender,
      );

  Map<String, String> toQueryParams() {
    final Map<String, String> queryParams = {};

    Map<String, String?> properties = {
      'name': name,
      'status': status?.toString(),
      'species': species,
      'type': type,
      'gender': gender?.toString(),
    };

    properties.forEach((key, value) {
      if (value != null) {
        queryParams[key] = value;
      }
    });

    return queryParams;
  }
}
