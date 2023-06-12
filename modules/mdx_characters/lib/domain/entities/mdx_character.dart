import 'package:equatable/equatable.dart';

enum MDXCharacterStatus { alive, dead, unknown }

enum MDXCharacterGender { female, male, genderless, unknown }

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
