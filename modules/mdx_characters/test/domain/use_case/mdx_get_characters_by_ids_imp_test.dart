import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_core/mdx_core.dart';
import 'package:mdx_characters/mdx_characters.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/entities/character_mocks.dart';
import '../../fixtures/interfaces/mdx_character_repository.mocks.dart';

void main() {
  late MDXGetCharactersByIdsImp usecase;
  late MockMDXCharacterRepository mockCharacterRepository;
  final mockCharacterDataGenerator = MockCharacterDataGenerator();

  setUp(() {
    mockCharacterRepository = MockMDXCharacterRepository();
    usecase =
        MDXGetCharactersByIdsImp(characterRepository: mockCharacterRepository);
  });

  final tCharacters = [
    mockCharacterDataGenerator.getMockCharacter(),
    mockCharacterDataGenerator.getMockCharacter(),
  ];
  final tIdList = tCharacters.map((character) => character.id).toList();

  group('MDXGetCharactersByIdsImp', () {
    test('should get characters from the repository', () async {
      // arrange
      when(mockCharacterRepository.getCharactersByIds(any))
          .thenAnswer((_) async => tCharacters);
      // act
      final result = await usecase(tIdList);
      // assert
      expect(result.right, equals(tCharacters));
      verify(mockCharacterRepository.getCharactersByIds(tIdList));
      verifyNoMoreInteractions(mockCharacterRepository);
    });

    test('should return Failure when call to repository throws an exception',
        () async {
      // arrange
      when(mockCharacterRepository.getCharactersByIds(any))
          .thenThrow(Exception());
      // act
      final result = await usecase(tIdList);
      // assert
      expect(result.left, isInstanceOf<Failure>());
      verify(mockCharacterRepository.getCharactersByIds(tIdList));
      verifyNoMoreInteractions(mockCharacterRepository);
    });
  });
}
