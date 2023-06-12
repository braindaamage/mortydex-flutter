import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_core/mdx_core.dart';
import 'package:mdx_characters/mdx_characters.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/entities/character_mocks.dart';
import '../../fixtures/interfaces/mdx_character_repository.mocks.dart';

void main() {
  late MDXGetFilteredCharactersImp usecase;
  late MockMDXCharacterRepository mockCharacterRepository;
  final mockCharacterDataGenerator = MockCharacterDataGenerator();

  setUp(() {
    mockCharacterRepository = MockMDXCharacterRepository();
    usecase = MDXGetFilteredCharactersImp(
        characterRepository: mockCharacterRepository);
  });

  final tCharacters = [
    mockCharacterDataGenerator.getMockCharacter(),
    mockCharacterDataGenerator.getMockCharacter(),
  ];
  const tNameFilter = 'Test Name Filter';
  const tGenderFilter = MDXCharacterGender.male;
  const filter = MDXCharacterFilter(name: tNameFilter, gender: tGenderFilter);

  group('MDXGetFilteredCharactersImp', () {
    test('should get characters from the repository', () async {
      // arrange
      when(mockCharacterRepository.getFilteredCharacters(any))
          .thenAnswer((_) async => tCharacters);
      // act
      final result = await usecase(filter);
      // assert
      expect(result.right, equals(tCharacters));
      expect(result.right.length, equals(2));
      verify(mockCharacterRepository.getFilteredCharacters(filter));
      verifyNoMoreInteractions(mockCharacterRepository);
    });

    test('should return Failure when call to repository throws an exception',
        () async {
      // arrange
      when(mockCharacterRepository.getFilteredCharacters(any))
          .thenThrow(Exception());
      // act
      final result = await usecase(filter);
      // assert
      expect(result.left, isInstanceOf<Failure>());
      verify(mockCharacterRepository.getFilteredCharacters(filter));
      verifyNoMoreInteractions(mockCharacterRepository);
    });
  });
}
