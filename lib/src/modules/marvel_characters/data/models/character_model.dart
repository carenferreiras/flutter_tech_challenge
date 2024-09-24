import 'package:flutter_tech_challenge/src/modules/marvel_characters/marvel_characters.dart';

class CharacterModel extends Character {
  CharacterModel({
    required int id,
    required String name,
    required String description,
    required String thumbnail,
  }) : super(
          id: 0,
          name: '',
          description: '',
          thumbnail: '',
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnail:
          "${json['thumbnail']['path']}.${json['thumbnail']['extension']}",
    );
  }
}
