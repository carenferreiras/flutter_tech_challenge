
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
    
    // Verificar se 'thumbnail' não é nulo antes de acessar 'path' e 'extension'
    final imageUrl = thumbnail != null
        ? '${thumbnail['path'] ?? ''}.${thumbnail['extension'] ?? ''}'
        : '';

    return CharacterModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? 'No description available.',
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    // Se 'imageUrl' não for vazio, separar em 'path' e 'extension'
    final parts = imageUrl.isNotEmpty ? imageUrl.split('.') : ['', ''];

    return {
      'id': id,
      'name': name,
      'description': description,
      'thumbnail': {
        'path': parts[0], // Parte antes do ponto
        'extension': parts.length > 1 ? parts[1] : '', // Parte depois do ponto
      },
    };
  }
}