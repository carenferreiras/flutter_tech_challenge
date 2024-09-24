import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../marvel_characters.dart';

class CharacterRemoteDataSource {
  final Dio dio;

  CharacterRemoteDataSource(this.dio);

  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await dio.get(
        'https://gateway.marvel.com/v1/public/characters',
        queryParameters: {
          'ts': dotenv.env['TS'],
          'apikey': dotenv.env['API_KEY'],
          'hash': dotenv.env['HASH'], 
        },
      );
      final List results = response.data['data']['results'];
      return results.map((json) => CharacterModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching characters: $e');
    }
  }
}