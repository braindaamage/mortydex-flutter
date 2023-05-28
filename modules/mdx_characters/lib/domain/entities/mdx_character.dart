import 'package:mdx_characters/domain/entities/module.dart';

class MDXCharacter {
  final int id;
  final String name;
  final MDXCharacterStatus status;
  final String species;
  final String type;
  final MDXCharacterGender gender;
  final String imageUrl;
  final DateTime created;

  MDXCharacter({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.imageUrl,
    required this.created,
  });
}
