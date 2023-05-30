import 'package:equatable/equatable.dart';
import 'package:mdx_characters/mdx_characters.dart';

class MDXCharacterFilter extends Equatable {
  final String? name;
  final MDXCharacterStatus? status;
  final String? species;
  final String? type;
  final MDXCharacterGender? gender;

  MDXCharacterFilter({
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
  });

  @override
  List<Object?> get props => [name, status, species, type, gender];
}
