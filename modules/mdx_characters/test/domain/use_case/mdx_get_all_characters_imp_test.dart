import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_core/mdx_core.dart';
import 'package:mdx_characters/mdx_characters.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/entities/character_mocks.dart';
import '../../fixtures/interfaces/mdx_character_repository.mocks.dart';

void main() {
  late MDXGetAllCharactersImp usecase;
  late MockMDXCharacterRepository mockCharacterRepository;
  final mockCharacterDataGenerator = MockCharacterDataGenerator();

  setUp(() {
    mockCharacterRepository = MockMDXCharacterRepository();
    usecase =
        MDXGetAllCharactersImp(characterRepository: mockCharacterRepository);
  });

  const tPage = 1;
  final tCharacters = [
    mockCharacterDataGenerator.getMockCharacter(),
    mockCharacterDataGenerator.getMockCharacter(),
  ];

  group('MDXGetAllCharactersImp', () {
    test('should get character from the repository', () async {
      // arrange
      when(mockCharacterRepository.getAllCharacters(any))
          .thenAnswer((_) async => tCharacters);
      // act
      final result = await usecase(tPage);
      // assert
      expect(result.right, equals(tCharacters));
      verify(mockCharacterRepository.getAllCharacters(tPage));
      verifyNoMoreInteractions(mockCharacterRepository);
    });

    test('should return Failure when call to repository throws an exception',
        () async {
      // arrange
      when(mockCharacterRepository.getAllCharacters(any))
          .thenThrow(Exception());
      // act
      final result = await usecase(tPage);
      // assert
      expect(result.left, isInstanceOf<Failure>());
      verify(mockCharacterRepository.getAllCharacters(tPage));
      verifyNoMoreInteractions(mockCharacterRepository);
    });
  });
}
