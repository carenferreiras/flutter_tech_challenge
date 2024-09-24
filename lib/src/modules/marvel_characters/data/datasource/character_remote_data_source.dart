import 'package:dio/dio.dart';

import '../../marvel_characters.dart';

class CharacterRemoteDataSource {
  final Dio dio;

  CharacterRemoteDataSource(this.dio);

  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await dio.get(
        'https://gateway.marvel.com/v1/public/characters',
        queryParameters: {
          'ts': '1',
          'apikey': 'bc9b32ce3a1e6558d35eb1237611ed2e',
          'hash': '4756f30101f4460894859d2aee1bd60d',
        },
      );
      final List results = response.data['data']['results'];
      return results.map((json) => CharacterModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching characters: $e');
    }
  }
}