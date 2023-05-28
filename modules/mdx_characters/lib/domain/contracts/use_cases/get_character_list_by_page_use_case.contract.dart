import 'package:mdx_characters/mdx_characters.dart';

abstract interface class GetCharacterListByPageUseCaseProtocol {
  Future<List<MDXCharacter>> call({required int byPage});
}
