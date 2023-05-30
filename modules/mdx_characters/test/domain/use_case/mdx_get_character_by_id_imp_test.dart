import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_core/mdx_core.dart';
import 'package:mdx_characters/mdx_characters.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mdx_get_character_by_id_imp_test.mocks.dart';

// Need run 'dart run build_runner build' for regenerate mock
@GenerateMocks([], customMocks: [
  MockSpec<MDXCharacterRepository>(as: #MockMDXCharacterRepository)
])
void main() {
  late MDXGetCharacterByIdImp usecase;
  late MockMDXCharacterRepository mockCharacterRepository;

  setUp(() {
    mockCharacterRepository = MockMDXCharacterRepository();
    usecase =
        MDXGetCharacterByIdImp(characterRepository: mockCharacterRepository);
  });

  const tId = 1;
  final tCharacter = MDXCharacter(
    id: tId,
    name: 'Test Character',
    status: MDXCharacterStatus.alive,
    species: 'Human',
    type: 'Normal',
    gender: MDXCharacterGender.male,
    imageUrl: 'https://test.com/image.png',
    created: DateTime.now(),
  );

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
    when(mockCharacterRepository.getCharacterById(any)).thenThrow(Exception());
    // act
    final result = await usecase(tId);
    // assert
    expect(result.left, isInstanceOf<Failure>());
    verify(mockCharacterRepository.getCharacterById(tId));
    verifyNoMoreInteractions(mockCharacterRepository);
  });
}
