import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/mdx_core.dart';

abstract interface class GetCharacterListByPageUseCaseProtocol {
  Future<MDXResponse<List<MDXCharacter>, MDXFailure>> call({
    required int byPage,
  });
}
