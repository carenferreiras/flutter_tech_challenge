import '../../marvel_characters.dart';

abstract class CharacterRepository {
  Future<List<CharacterEntity>> getCharacteres();
}
