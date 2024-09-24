
import '../../marvel_characters.dart';

class CharacterModel extends Character {
  CharacterModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'];
    final imageUrl = '${thumbnail['path']}.${thumbnail['extension']}';
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? 'No description available.',
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'thumbnail': {
        'path': imageUrl.split('.').first,
        'extension': imageUrl.split('.').last,
      },
    };
  }
}