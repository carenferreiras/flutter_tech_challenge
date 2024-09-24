import '../../marvel_characters.dart';

class GetCharactersUsecase {
  final CharacterRepository repository;

  GetCharactersUsecase(this.repository);

  Future<List<Character>> call() async {
    return await repository.getCharacters();
  }
}
