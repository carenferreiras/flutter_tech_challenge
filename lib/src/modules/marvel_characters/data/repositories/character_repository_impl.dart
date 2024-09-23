import '../../marvel_characters.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource dataSource;

  CharacterRepositoryImpl(this.dataSource);

  @override
  Future<List<Character>> getCharacteres() async {
    try {
      return await dataSource.getCharacteres();
    } catch (e) {
      throw Exception('Failed to fetch characters: $e');
    }
  }
}
