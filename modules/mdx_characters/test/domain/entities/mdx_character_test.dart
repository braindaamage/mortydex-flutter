import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/entities/character_mocks.dart';

void main() {
  final mockCharacterDataGenerator = MockCharacterDataGenerator();

  final character = mockCharacterDataGenerator.getMockCharacter();
  final identicalCharacter =
      mockCharacterDataGenerator.getMockCharacter(character.id);
  final differentCharacter = mockCharacterDataGenerator.getMockCharacter();

  group('MDXCharacter Equatable', () {
    test('equality should work as expected', () {
      // The entity should be equal to itself
      expect(character, equals(character));
      // Two entities with the same properties should be equal
      expect(character, equals(identicalCharacter));
      // Two entities with different properties should not be equal
      expect(character, isNot(equals(differentCharacter)));
    });
  });
}
