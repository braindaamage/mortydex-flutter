import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_network/mdx_network.dart';
import 'package:mock_mdx_network/mock_mdx_network.dart';

// import '../../fixtures/interfaces/mdx_network.mocks.dart';

void main() {
  late MockMDXNetwork mockMDXNetwork;
  late MDXCharacterCloudDataSourceImp mdxCharacterCloudDataSourceImp;

  const tPage = 1;
  const tId = 1;

  group('MDXCharacterCloudDataSourceImp', () {
    setUp(() async {
      mockMDXNetwork = MockMDXNetwork(filesPath: {
        Endpoints.character:
            'test/fixtures/api_responses/success/character.json',
        Endpoints.characters:
            'test/fixtures/api_responses/success/characters.json',
        Endpoints.charactersByIds:
            'test/fixtures/api_responses/success/characters_by_ids.json',
        Endpoints.charactersFilter:
            'test/fixtures/api_responses/success/characters_filtered.json',
      });
      mdxCharacterCloudDataSourceImp =
          MDXCharacterCloudDataSourceImp(networkClient: mockMDXNetwork);
    });
    group('Character', () {
      test('should return a MDXCharacter', () async {
        // arrange
        // act
        final result =
            await mdxCharacterCloudDataSourceImp.getCharacterById(tId);
        // assert
        expect(result, isA<MDXCharacter>());
        expect(result.id, equals(tId));
      });
    });
    group('Lists', () {
      test('getAllCharacter should be return a list of characters', () async {
        // arrange
        // act
        final result =
            await mdxCharacterCloudDataSourceImp.getAllCharacters(tPage);
        // assert
        expect(result, isA<List<MDXCharacter>>());
        expect(result.length, equals(20));
      });
      test('getCharactersByIds should be return a list of the characters',
          () async {
        // arrange
        const tId2 = 2;
        const tIds = [tId, tId2];
        // act
        final result =
            await mdxCharacterCloudDataSourceImp.getCharactersByIds(tIds);
        // assert
        expect(result, isA<List<MDXCharacter>>());
        expect(result.length, equals(2));
        expect(result.map((c) => c.id).toList(), equals(tIds));
      });
      test('getFilteredCharacters should be return a filter list of characters',
          () async {
        // arrange
        const filter = MDXCharacterFilter(gender: MDXCharacterGender.male);
        // act
        final result =
            await mdxCharacterCloudDataSourceImp.getFilteredCharacters(filter);
        // assert
        expect(result, isA<List<MDXCharacter>>());
        expect(result.length, equals(2));
      });
    });
  });
}
