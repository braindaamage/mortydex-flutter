import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_network/mdx_network.dart';
import 'package:mock_mdx_network/mock_mdx_network.dart';

// import '../../fixtures/interfaces/mdx_network.mocks.dart';

void main() {
  late MockMDXNetwork mockMDXNetwork;
  late MDXCharacterCloudDataSourceImp mdxCharacterCloudDataSourceImp;

  const tPage = 1;

  group('MDXCharacterCloudDataSourceImp', () {
    group('Lists', () {
      setUp(() async {
        mockMDXNetwork = MockMDXNetwork(filesPath: {
          Endpoints.character:
              'test/fixtures/api_responses/success/character.json',
          Endpoints.characters:
              'test/fixtures/api_responses/success/characters.json',
        });
        mdxCharacterCloudDataSourceImp =
            MDXCharacterCloudDataSourceImp(networkClient: mockMDXNetwork);
      });
      test('should be return a list of characters', () async {
        // arrange
        // act
        final result =
            await mdxCharacterCloudDataSourceImp.getAllCharacters(tPage);
        // assert
        expect(result, isA<List<MDXCharacter>>());
        expect(result.length, equals(20));
      });
    });
  });
}
