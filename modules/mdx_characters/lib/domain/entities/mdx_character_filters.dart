import 'package:mdx_characters/mdx_characters.dart';

class MDXCharacterFilter {
  final String? name;
  final MDXCharacterStatus? status;
  final String? species;
  final String? type;
  final MDXCharacterGender? gender;

  const MDXCharacterFilter({
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
  });
}
