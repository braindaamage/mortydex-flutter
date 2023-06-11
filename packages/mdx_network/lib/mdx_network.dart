import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:mdx_core/mdx_core.dart';

typedef FromJson<T> = T Function(Map<String, dynamic>);

enum Endpoints {
  characters,
  character,
}

abstract class MDXNetwork {
  static MDXNetwork _instance = DefaultMDXNetwork(
    client: http.Client(),
    baseUrl: 'https://rickandmortyapi.com/api/',
  );

  static MDXNetwork get instance => _instance;

  Future<T> get<T>(
    Endpoints endpoint, {
    required FromJson<T> fromJson,
    String? param,
    Map<String, String>? queryParams,
  });

  // ignore: use_setters_to_change_properties
  static void overrideDefault(MDXNetwork instance) {
    _instance = instance;
  }
}

class DefaultMDXNetwork extends MDXNetwork {
  final http.Client _client;
  final String _baseUrl;

  DefaultMDXNetwork({
    required http.Client client,
    required String baseUrl,
  })  : _client = client,
        _baseUrl = baseUrl;

  @override
  Future<T> get<T>(
    Endpoints endpoint, {
    required FromJson<T> fromJson,
    String? param,
    Map<String, String>? queryParams,
  }) async {
    final uri = _generateUri(
      endpoint,
      param,
      queryParams,
    );
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      return fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw NetworkException();
    }
  }

  Uri _generateUri(
    Endpoints endpoint, [
    String? param,
    Map<String, String>? queryParams,
  ]) {
    final path = _generatePath(endpoint, param);
    return Uri.https(_baseUrl, path, queryParams);
  }

  String _generatePath(
    Endpoints endpoint, [
    String? param,
  ]) {
    switch (endpoint) {
      case Endpoints.characters:
        return 'character';
      case Endpoints.character:
        return 'character/$param';
    }
  }
}
