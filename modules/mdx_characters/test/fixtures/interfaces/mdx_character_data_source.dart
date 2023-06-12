import 'package:mockito/annotations.dart';
import 'package:mdx_characters/mdx_characters.dart';

// Use for declare and generate Mock class for all use cases tests

// Need run 'dart run build_runner build' for regenerate mock

@GenerateMocks([], customMocks: [
  MockSpec<MDXCharacterCloudDataSource>(as: #MockMDXCharacterCloudDataSource),
])
void main() {}
