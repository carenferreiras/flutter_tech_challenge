
import '../../marvel_characters.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource dataSource;

  CharacterRepositoryImpl(this.dataSource);

  @override
  Future<List<Character>> getCharacters() async {
    return await dataSource.getCharacters();
  }
}
