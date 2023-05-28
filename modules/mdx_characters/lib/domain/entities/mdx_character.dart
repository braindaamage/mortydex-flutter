import 'package:equatable/equatable.dart';
import 'package:mdx_characters/mdx_characters.dart';

class MDXCharacter extends Equatable {
  final int id;
  final String name;
  final MDXCharacterStatus status;
  final String species;
  final String type;
  final MDXCharacterGender gender;
  final String imageUrl;
  final DateTime created;

  const MDXCharacter({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.imageUrl,
    required this.created,
  });

  @override
  List<Object?> get props => [id];
}
