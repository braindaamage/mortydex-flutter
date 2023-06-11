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
    required FromJson<T> fromJson,
    String? param,
    Map<String, String>? queryParams,
  }) =>
      _loadFixture<T>(endpoint, fromJson);

  Future<T> _loadFixture<T>(Endpoints endpoint, FromJson<T> fromJson) async {
    final String filePath = filesPath[endpoint]!;

    final String fixtureString = await File(filePath).readAsString();
    final Map<String, dynamic> jsonFixture =
        jsonDecode(fixtureString) as Map<String, dynamic>;

    return fromJson(jsonFixture);
  }
}
