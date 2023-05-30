import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_core/mdx_core.dart';
import 'package:mdx_characters/mdx_characters.dart';
import 'package:mockito/mockito.dart';

import 'use_case_mockito_generator.mocks.dart';

void main() {
  late MDXGetFilteredCharactersImp usecase;
  late MockMDXCharacterRepository mockCharacterRepository;

  setUp(() {
    mockCharacterRepository = MockMDXCharacterRepository();
    usecase = MDXGetFilteredCharactersImp(
        characterRepository: mockCharacterRepository);
  });

  const tNameFilter = 'Test Character';
  const tGenderFilter = MDXCharacterGender.male;
  final filter = MDXCharacterFilter(name: tNameFilter, gender: tGenderFilter);
  final tCharacters = [
    MDXCharacter(
      id: 1,
      name: 'Test Character',
      status: MDXCharacterStatus.alive,
      species: 'Human',
      type: 'Normal',
      gender: MDXCharacterGender.male,
      imageUrl: 'https://test.com/image.png',
      created: DateTime.now(),
    ),
    MDXCharacter(
      id: 2,
      name: 'Test Character',
      status: MDXCharacterStatus.alive,
      species: 'Human',
      type: 'Normal',
      gender: MDXCharacterGender.male,
      imageUrl: 'https://test.com/image.png',
      created: DateTime.now(),
    ),
  ];

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
}
