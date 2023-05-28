import 'package:mdx_characters/mdx_characters.dart';
import 'package:mdx_core/mdx_core.dart';

abstract interface class GetCharacterByIdUseCaseProtocol {
  Future<MDXResponse<MDXCharacter, MDXFailure>> call({
    required int byId,
  });
}
