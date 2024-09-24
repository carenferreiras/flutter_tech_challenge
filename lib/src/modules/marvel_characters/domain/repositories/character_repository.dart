import '../../marvel_characters.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters();
}
