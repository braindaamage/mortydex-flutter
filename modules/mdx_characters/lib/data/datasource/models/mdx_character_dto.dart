import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/mdx_core.dart';

class MDXCharacterDTO extends MDXCharacter {
  const MDXCharacterDTO({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.imageUrl,
    required super.created,
  });

  factory MDXCharacterDTO.fromJson(Map<String, dynamic> json) {
    try {
      return MDXCharacterDTO(
        id: json['id'],
        name: json['name'],
        status: _statusFromString(json['status']),
        species: json['species'],
        type: json['type'],
        gender: _genderFromString(json['gender']),
        imageUrl: json['image'],
        created: DateTime.parse(json['created']),
      );
    } catch (error) {
      throw MapperException();
    }
  }

  static MDXCharacterStatus _statusFromString(String status) {
    switch (status) {
      case 'Alive':
        return MDXCharacterStatus.alive;
      case 'Dead':
        return MDXCharacterStatus.dead;
      default:
        return MDXCharacterStatus.unknown;
    }
  }

  static MDXCharacterGender _genderFromString(String gender) {
    switch (gender) {
      case 'Female':
        return MDXCharacterGender.female;
      case 'Male':
        return MDXCharacterGender.male;
      case 'Genderless':
        return MDXCharacterGender.genderless;
      default:
        return MDXCharacterGender.unknown;
    }
  }

  MDXCharacter toEntity() {
    return MDXCharacter(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      imageUrl: imageUrl,
      created: created,
    );
  }
}
