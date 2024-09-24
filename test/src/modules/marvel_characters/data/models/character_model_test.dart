import 'package:flutter_tech_challenge/src/modules/marvel_characters/marvel_characters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CharacterModel Tests', () {
    final testJson = {
      'id': 1,
      'name': 'Spider-Man',
      'description': 'Friendly neighborhood Spider-Man.',
      'thumbnail': {
        'path': 'http://example.com/spiderman',
        'extension': 'jpg',
      },
    };

    final testJsonWithNullThumbnail = {
      'id': 2,
      'name': 'Iron Man',
      'description': 'Genius billionaire Tony Stark.',
      'thumbnail': null, 
    };

    final testCharacterModel = CharacterModel(
      id: 1,
      name: 'Spider-Man',
      description: 'Friendly neighborhood Spider-Man.',
      imageUrl: 'http://example.com/spiderman.jpg',
    );

    final testCharacterModelWithNullThumbnail = CharacterModel(
      id: 2,
      name: 'Iron Man',
      description: 'Genius billionaire Tony Stark.',
      imageUrl: '', 
    );

    test('should correctly map from JSON to CharacterModel', () {
      final result = CharacterModel.fromJson(testJson);

      expect(result.id, testCharacterModel.id);
      expect(result.name, testCharacterModel.name);
      expect(result.description, testCharacterModel.description);
      expect(result.imageUrl, testCharacterModel.imageUrl);

    });

    test('should handle null thumbnail correctly when mapping from JSON', () {
      final result = CharacterModel.fromJson(testJsonWithNullThumbnail);

      expect(result.id, testCharacterModelWithNullThumbnail.id);
      expect(result.name, testCharacterModelWithNullThumbnail.name);
      expect(result.description, testCharacterModelWithNullThumbnail.description);
      expect(result.imageUrl, testCharacterModelWithNullThumbnail.imageUrl); 

    });


    test('should map CharacterModel with null thumbnail back to JSON correctly', () {
      final result = testCharacterModelWithNullThumbnail.toJson();

      expect(result['id'], testJsonWithNullThumbnail['id']);
      expect(result['name'], testJsonWithNullThumbnail['name']);
      expect(result['description'], testJsonWithNullThumbnail['description']);
      expect(result['thumbnail']['path'], ''); 
      expect(result['thumbnail']['extension'], '');

    });
  });
}