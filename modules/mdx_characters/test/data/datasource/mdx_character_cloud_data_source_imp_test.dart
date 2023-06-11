import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_network/mdx_network.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/interfaces/mdx_network.mocks.dart';

void main() {
  late MockClient mockClient;
  late MDXCharacterCloudDataSourceImp mdxCharacterCloudDataSourceImp;

  const tPage = 1;

  group('MDXCharacterCloudDataSourceImp', () {
    late String jsonString;

    setUp(() async {
      mockClient = MockClient();
      MDXNetwork.overrideDefault(DefaultMDXNetwork(
        client: mockClient,
        baseUrl: '',
      ));
      mdxCharacterCloudDataSourceImp =
          MDXCharacterCloudDataSourceImp(networkClient: MDXNetwork.instance);

      // Read the text file into a string
      final file = File('test/fixtures/api_responses/success/characters.json');
      jsonString = await file.readAsString();
    });
    test('should be return a list of characters', () async {
      // arrange
      when(mockClient.get(any)).thenAnswer(
        (_) async => http.Response(
          jsonString,
          200,
        ),
      );
      // act
      final result =
          await mdxCharacterCloudDataSourceImp.getAllCharacters(tPage);
      // assert
      expect(result, isA<List<MDXCharacterDTO>>());
      expect(result.length, equals(20));
      verify(mockClient.get(any));
      verifyNoMoreInteractions(mockClient);
    });
  });
}
