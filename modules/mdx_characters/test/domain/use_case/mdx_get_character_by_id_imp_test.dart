import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_core/mdx_core.dart';
import 'package:mdx_characters/mdx_characters.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/entities/character_mocks.dart';
import '../../fixtures/interfaces/mdx_character_repository.mocks.dart';

void main() {
  late MDXGetCharacterByIdImp usecase;
  late MockMDXCharacterRepository mockCharacterRepository;
  final mockCharacterDataGenerator = MockCharacterDataGenerator();

  setUp(() {
    mockCharacterRepository = MockMDXCharacterRepository();
    usecase =
        MDXGetCharacterByIdImp(characterRepository: mockCharacterRepository);
  });

  final tCharacter = mockCharacterDataGenerator.getMockCharacter();
  final tId = tCharacter.id;

  group('MDXGetCharacterByIdImp', () {
    test('should get character from the repository', () async {
      // arrange
      when(mockCharacterRepository.getCharacterById(any))
          .thenAnswer((_) async => tCharacter);
      // act
      final result = await usecase(tId);
      // assert
      expect(result.right, equals(tCharacter));
      verify(mockCharacterRepository.getCharacterById(tId));
      verifyNoMoreInteractions(mockCharacterRepository);
    });

    test('should return Failure when call to repository throws an exception',
        () async {
      // arrange
      when(mockCharacterRepository.getCharacterById(any))
          .thenThrow(Exception());
      // act
      final result = await usecase(tId);
      // assert
      expect(result.left, isInstanceOf<Failure>());
      verify(mockCharacterRepository.getCharacterById(tId));
      verifyNoMoreInteractions(mockCharacterRepository);
    });
  });
}
