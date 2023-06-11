import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

// Use for declare and generate Mock class for all use cases tests

// Need run 'dart run build_runner build' for regenerate mock

@GenerateMocks([http.Client])
void main() {}
