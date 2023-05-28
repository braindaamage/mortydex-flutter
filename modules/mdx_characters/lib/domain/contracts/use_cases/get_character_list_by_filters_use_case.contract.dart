import 'package:mdx_characters/mdx_characters.dart';

abstract interface class GetCharacterListByFiltersUseCaseProtocol {
  Future<List<MDXCharacter>> call(
      {required Map<MDXCharacterFilter, String> byFilters});
}
