import 'package:mdx_characters/mdx_characters.dart';

abstract interface class GetCharacterByIdUseCaseProtocol {
  Future<MDXCharacter> call({required int byId});
}
