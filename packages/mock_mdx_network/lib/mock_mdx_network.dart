import 'dart:convert';
import 'dart:io';
import 'package:mdx_network/mdx_network.dart';
import 'package:mockito/mockito.dart';

class MockMDXNetwork extends Fake implements MDXNetwork {
  final Map<Endpoints, String> filesPath;

  MockMDXNetwork({required this.filesPath});

  @override
  Future<T> get<T>(
    Endpoints endpoint, {
    FromJson<T>? fromJson,
    FromJsonList<T>? fromJsonList,
    String? param,
    Map<String, String>? queryParams,
  }) =>
      _loadFixture<T>(endpoint, fromJson, fromJsonList);

  Future<T> _loadFixture<T>(
    Endpoints endpoint,
    FromJson<T>? fromJson,
    FromJsonList<T>? fromJsonList,
  ) async {
    final String filePath = filesPath[endpoint]!;

    final String fixtureString = await File(filePath).readAsString();

    final decodedResponse = jsonDecode(fixtureString);
    if (decodedResponse is Map<String, dynamic> && fromJson != null) {
      return fromJson(decodedResponse);
    } else if (decodedResponse is List<dynamic> && fromJsonList != null) {
      return fromJsonList(decodedResponse);
    } else {
      throw UnimplementedError();
    }
  }
}
