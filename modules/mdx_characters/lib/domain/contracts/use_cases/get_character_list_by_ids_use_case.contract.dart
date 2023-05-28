import 'package:mdx_characters/mdx_characters.dart';

abstract interface class GetCharacterListByIdsUseCaseProcotol {
  Future<List<MDXCharacter>> call({required List<int> byIds});
}
