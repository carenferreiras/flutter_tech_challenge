import '../../marvel_characters.dart';

class GetCharactersUsecase {
  final CharacterRepository repository;

  GetCharactersUsecase(this.repository);

  Future<List<Character>> getCharacteres() async {
    return await repository.getCharacteres();
  }
}
