import 'package:flutter_tech_challenge/src/core/core.dart';

import '../../marvel_characters.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource dataSource;

  CharacterRepositoryImpl(this.dataSource);

  @override
  Future<List<CharacterModel>> getCharacteres() async {
    try {
      AppLogger.logInfo(
          'Calling CharacterRemoteDataSource to fech characteres');
      final characteres = await dataSource.getCharacteres();
      AppLogger.logInfo('Characters Fetched sucessfully from DataSource');
      return characteres;
    } catch (e) {
      AppLogger.logError('Error in CharacterRepositoryImpl: $e');
      throw Exception('Failed to fetch characters: $e');
    }
  }
}
