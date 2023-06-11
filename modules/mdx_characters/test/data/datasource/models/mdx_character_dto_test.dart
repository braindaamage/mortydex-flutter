import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/mdx_core.dart';

void main() {
  group('MDXCharacterDTO', () {
    group('SUCCESS', () {
      late Map<String, dynamic> jsonData;

      setUp(() async {
        // Read the text file into a string
        final file = File('test/fixtures/api_responses/success/character.json');
        final jsonString = await file.readAsString();

        // Convert the string to a Map<String, dynamic>
        jsonData = jsonDecode(jsonString);
      });
      test('should parse from json correctly', () {
        // Pass the data to the fromJson method
        final character = MDXCharacterDTO.fromJson(jsonData);

        // Here you can add the checks you want
        // for example, check that the fields of the object are correct
        expect(character.id, equals(jsonData['id']));
        expect(character.name, equals(jsonData['name']));
        expect(character.species, equals(jsonData['species']));
        expect(character.type, equals(jsonData['type']));
        expect(character.imageUrl, equals(jsonData['image']));
        expect(character.created, equals(DateTime.parse(jsonData['created'])));
      });

      test('toEntity should return a MDXCharacter with same values', () {
        // Given
        final characterDTO = MDXCharacterDTO.fromJson(jsonData);

        // When
        final entity = characterDTO.toEntity();

        // Then
        expect(entity, isA<MDXCharacter>());
        expect(entity.id, equals(characterDTO.id));
        expect(entity.name, equals(characterDTO.name));
        expect(entity.status, equals(characterDTO.status));
        expect(entity.species, equals(characterDTO.species));
        expect(entity.type, equals(characterDTO.type));
        expect(entity.gender, equals(characterDTO.gender));
        expect(entity.imageUrl, equals(characterDTO.imageUrl));
        expect(entity.created, equals(characterDTO.created));
      });
    });

    test('should throw MapperException when json data is not valid', () async {
      // An invalid Map<String, dynamic>
      final file = File('test/fixtures/api_responses/error/character.json');
      final jsonString = await file.readAsString();

      // Convert the string to a Map<String, dynamic>
      final jsonData = jsonDecode(jsonString);

      // Pass the data to the fromJson method and check if it throws the exception
      expect(() => MDXCharacterDTO.fromJson(jsonData),
          throwsA(isA<MapperException>()));
    });
  });
}
