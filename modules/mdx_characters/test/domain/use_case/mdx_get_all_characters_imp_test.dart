import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_core/mdx_core.dart';
import 'package:mdx_characters/mdx_characters.dart';
import 'package:mockito/mockito.dart';

import 'use_case_mockito_generator.mocks.dart';

void main() {
  late MDXGetAllCharactersImp usecase;
  late MockMDXCharacterRepository mockCharacterRepository;

  setUp(() {
    mockCharacterRepository = MockMDXCharacterRepository();
    usecase =
        MDXGetAllCharactersImp(characterRepository: mockCharacterRepository);
  });

  const tId = 1;
  final tCharacters = [
    MDXCharacter(
      id: tId,
      name: 'Test Character',
      status: MDXCharacterStatus.alive,
      species: 'Human',
      type: 'Normal',
      gender: MDXCharacterGender.male,
      imageUrl: 'https://test.com/image.png',
      created: DateTime.now(),
    ),
  ];

  test('should get character from the repository', () async {
    // arrange
    when(mockCharacterRepository.getAllCharacters(any))
        .thenAnswer((_) async => tCharacters);
    // act
    final result = await usecase(tId);
    // assert
    expect(result.right, equals(tCharacters));
    verify(mockCharacterRepository.getAllCharacters(tId));
    verifyNoMoreInteractions(mockCharacterRepository);
  });

  test('should return Failure when call to repository throws an exception',
      () async {
    // arrange
    when(mockCharacterRepository.getAllCharacters(any)).thenThrow(Exception());
    // act
    final result = await usecase(tId);
    // assert
    expect(result.left, isInstanceOf<Failure>());
    verify(mockCharacterRepository.getAllCharacters(tId));
    verifyNoMoreInteractions(mockCharacterRepository);
  });
}
