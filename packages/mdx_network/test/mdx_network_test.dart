import 'package:http/http.dart' as http;
import 'package:mdx_core/mdx_core.dart';
import 'package:mdx_network/mdx_network.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import './mdx_network_test.mocks.dart';

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
        final networkInstance = MockMDXNetwork();
        // act
        MDXNetwork.overrideDefault(networkInstance);
        // assert
        expect(MDXNetwork.instance, networkInstance);
      });
    });
    group('DefaultMDXNetwork', () {
      late MockClient mockClient;
      late DefaultMDXNetwork network;

      setUp(() {
        mockClient = MockClient();
        network = DefaultMDXNetwork(client: mockClient, baseUrl: '');
      });

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
      });

      // TODO: Make tests for uri maker
      // group('UriMaker', () {});
    });
  });
}
