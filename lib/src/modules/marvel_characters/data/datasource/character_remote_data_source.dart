import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/core.dart';
import '../../marvel_characters.dart';

class CharacterRemoteDataSource {
  final Dio dio;

  CharacterRemoteDataSource(this.dio);

  Future<List<CharacterModel>> getCharacteres() async {
    try {
      final String ts = DateTime.now().millisecondsSinceEpoch.toString();
      final String publicKey = dotenv.env['API_KEY']!;
      final String privateKey = dotenv.env['PRIVATE_KEY']!;
      final String hash = HashGenerator.generateHash(ts, privateKey, publicKey);

      final response = await dio.get(
          '${ApiConstants.baseUrl}${ApiConstants.charactersEndpoint}',
          queryParameters: {
            "apikey": publicKey,
            "ts": ts,
            "hash": hash,
          });

      if (response.statusCode == 200) {
        final data = response.data['data']['results'] as List;
        return data
            .map((character) => CharacterModel.fromJson(character))
            .toList();
      } else {
        throw Exception(
            'Failed to load characters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching characters: $e');
    }
  }
}
