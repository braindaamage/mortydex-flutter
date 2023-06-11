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
    group('MDXNetwork', () {
      test('should by default instance', () {
        expect(MDXNetwork.instance, isA<DefaultMDXNetwork>());
      });
      test('should override default instance', () {
        final networkInstance = MockMDXNetwork();
        MDXNetwork.overrideDefault(networkInstance);
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
        when(mockClient.get(any)).thenAnswer(
          (_) async => http.Response(
            '{"id":1}',
            200,
          ),
        );

        final model = await network.get(
          Endpoints.character,
          fromJson: NetworkModel.fromJson,
        );
        expect(model.id, 1);
      });

      test('throws an exception if the http call completes with an error',
          () async {
        when(mockClient.get(any))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        await expectLater(
          network.get<NetworkModel>(
            Endpoints.character,
            fromJson: NetworkModel.fromJson,
          ),
          throwsA(isA<NetworkException>()),
        );
      });
    });
  });
}
