import 'package:flutter_tech_challenge/src/modules/marvel_characters/marvel_characters.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){


  group('Character Entity', (){

    test('Should create a character entity correctly', (){
final character = Character(
      id: 1,
      name: 'Spider-Man',
      description: 'Friendly neighborhood Spider-Man.',
      imageUrl: 'http://example.com/spiderman.jpg',

    );

    expect(character.id, 1);
    expect(character.name, 'Spider-Man');
    expect(character.description, 'Friendly neighborhood Spider-Man.');
    expect(character.imageUrl, 'http://example.com/spiderman.jpg');
    });
      
  });

  test('Should handle empry description correctly', (){
    final character =  Character(
      id: 2,
      name: 'Iron Man',
      description: '',
      imageUrl: 'http://example.com/ironman.jpg',
    );

    expect(character.description, '');
  });

  
}