import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mdx_core/mdx_core.dart';
import 'package:mdx_network/mdx_network.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import './mdx_network_test.mocks.dart' as mockito_client;

class NetworkModel {
  final int id;
  NetworkModel(this.id);

  factory NetworkModel.fromJson(Map<String, dynamic> json) {
    return NetworkModel(json['id'] as int);
  }
}

// Need run 'dart run build_runner build' for regenerate mock
@GenerateMocks([http.Client, MDXNetwork])
void main() {
  group('MDXNetwork', () {
    group('Abstract Class', () {
      test('should by default instance', () {
        // arrange
        // act
        // assert
        expect(MDXNetwork.instance, isA<DefaultMDXNetwork>());
      });
      test('should override default instance', () {
        // arrange
        final networkInstance = mockito_client.MockMDXNetwork();
        // act
        MDXNetwork.overrideDefault(networkInstance);
        // assert
        expect(MDXNetwork.instance, networkInstance);
      });
    });
    group('DefaultMDXNetwork', () {
      late mockito_client.MockClient mockClient;
      late DefaultMDXNetwork network;

      setUp(() {
        mockClient = mockito_client.MockClient();
        network =
            DefaultMDXNetwork(client: mockClient, baseUrl: '', baseApi: '');
      });

      group('http Client calls', () {
        test('returns data if the http call completes successfully', () async {
          // arrange
          when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response(
              '{"id":1}',
              200,
            ),
          );
          // act
          final model = await network.get(
            Endpoints.character,
            fromJson: NetworkModel.fromJson,
          );
          // assert
          expect(model.id, 1);
          verify(mockClient.get(any));
          verifyNoMoreInteractions(mockClient);
        });

        test('throws an exception if the http call completes with an error',
            () async {
          // arrange
          when(mockClient.get(any))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          // assert
          await expectLater(
            network.get<NetworkModel>(
              Endpoints.character,
              fromJson: NetworkModel.fromJson,
            ),
            throwsA(isA<NetworkException>()),
          );
        });

        test(
            'return a list of data if the http call completes successfully and the responde is a list',
            () async {
          // arrange
          when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response(
              '[{"id":1},{"id":2}]',
              200,
            ),
          );
          // act
          final model = await network.get(
            Endpoints.charactersByIds,
            fromJsonList: (jsonList) => jsonList
                .map((m) => NetworkModel.fromJson(m as Map<String, dynamic>))
                .toList(),
          );
          // assert
          expect(model, isA<List<NetworkModel>>());
          expect(model.length, equals(2));
          expect(model.map((m) => m.id).toList(), equals([1, 2]));
          verify(mockClient.get(any));
          verifyNoMoreInteractions(mockClient);
        });

        test('throws an exception if no transformation clousure is passed',
            () async {
          // arrange
          when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response(
              '{"id":1}',
              200,
            ),
          );
          // act
          // assert
          await expectLater(
            network.get<NetworkModel>(
              Endpoints.characters,
            ),
            throwsA(isA<NetworkTransformationException>()),
          );
        });
      });

      group('URI Generator', () {
        const baseUrl = 'testapi.test';
        test('should generate characters URI', () async {
          // Assert
          final mockClient = MockClient((request) async {
            // This will run for each request
            // So you can check the url here
            expect(
              request.url.toString(),
              'https://$baseUrl/character',
            );

            return http.Response(
              '{"id": 1}',
              200,
            );
          });

          final mdxNetwork = DefaultMDXNetwork(
            client: mockClient,
            baseUrl: baseUrl,
            baseApi: '/',
          );

          // Act
          await mdxNetwork.get(
            Endpoints.characters,
            fromJson: (json) => [],
          );
        });

        test('should generate character with id URI', () async {
          // Arrange
          const tId = 1;
          final mockClient = MockClient((request) async {
            // This will run for each request
            // So you can check the url here
            expect(
              request.url.toString(),
              'https://$baseUrl/character/$tId',
            );

            return http.Response(
              '{"id": 1}',
              200,
            );
          });

          final mdxNetwork = DefaultMDXNetwork(
            client: mockClient,
            baseUrl: baseUrl,
            baseApi: '/',
          );

          // Act
          await mdxNetwork.get(
            Endpoints.character,
            fromJson: (json) => [],
            param: tId.toString(),
          );
        });

        test('should generate character with two ids URI', () async {
          // Arrange
          const tId = 1;
          const tId2 = 2;
          final mockClient = MockClient((request) async {
            // This will run for each request
            // So you can check the url here
            expect(
              request.url.toString(),
              'https://$baseUrl/character/$tId,$tId2',
            );

            return http.Response(
              '{"id": 1}',
              200,
            );
          });

          final mdxNetwork = DefaultMDXNetwork(
            client: mockClient,
            baseUrl: baseUrl,
            baseApi: '/',
          );

          // Act
          await mdxNetwork.get(
            Endpoints.charactersByIds,
            fromJson: (json) => [],
            param: [tId, tId2].join(','),
          );
        });

        test('should generate character with query params filters URI',
            () async {
          // Arrange
          const Map<String, String> tFilters = {
            'name': 'Test Name',
            'gender': 'Test Gender',
          };
          final String tQueryParam = tFilters.entries
              .map((e) => '${e.key}=${e.value.replaceAll(' ', '+')}')
              .toList()
              .join('&');
          final mockClient = MockClient((request) async {
            // This will run for each request
            // So you can check the url here
            expect(
              request.url.toString(),
              'https://$baseUrl/character/?$tQueryParam',
            );

            return http.Response(
              '{"id": 1}',
              200,
            );
          });

          final mdxNetwork = DefaultMDXNetwork(
            client: mockClient,
            baseUrl: baseUrl,
            baseApi: '/',
          );

          // Act
          await mdxNetwork.get(
            Endpoints.charactersFilter,
            fromJson: (json) => [],
            queryParams: tFilters,
          );
        });
      });
    });
  });
}
