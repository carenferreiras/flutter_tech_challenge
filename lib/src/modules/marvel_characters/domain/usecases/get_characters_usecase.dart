import '../../marvel_characters.dart';

class GetCharactersUsecase {
  final CharacterRepository repository;

  GetCharactersUsecase(this.repository);

  Future<List<CharacterEntity>> getCharacteres() async {
    return await repository.getCharacteres();
  }
}
