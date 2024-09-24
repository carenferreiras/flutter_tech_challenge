import 'package:flutter_tech_challenge/src/modules/marvel_characters/marvel_characters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCharacterRemoteDataSource extends Mock implements CharacterRemoteDataSource{}


void main(){
  late CharacterRepositoryImpl repositoryImpl;
  late MockCharacterRemoteDataSource mockCharacterRemoteDataSource;

  setUp((){
    mockCharacterRemoteDataSource = MockCharacterRemoteDataSource();
    repositoryImpl = CharacterRepositoryImpl(mockCharacterRemoteDataSource);

  });

   final testCharacterModels = [
    CharacterModel(
      id: 1,
      name: 'Spider-Man',
      description: 'Friendly neighborhood Spider-Man.',
      imageUrl: 'http://example.com/spiderman.jpg',
    ),
    CharacterModel(
      id: 2,
      name: 'Iron Man',
      description: 'Genius billionaire Tony Stark.',
      imageUrl: 'http://example.com/ironman.jpg',
    ),
  ];

  test('Should retuyrn a list of characters when the call to data source is successful', ()async{
      when(() => mockCharacterRemoteDataSource.getCharacters(),)
      .thenAnswer((_) async => testCharacterModels);

      final result = await repositoryImpl.getCharacters();

      expect(result, isA<List<Character>>());
      expect(result.length, 2);
      expect(result.first.name, 'Spider-Man');
      verify(() => mockCharacterRemoteDataSource.getCharacters(),).called(1);
  });


  test('Should throw an exception when the call to data source fails', ()async{
    when(()=> mockCharacterRemoteDataSource.getCharacters()).thenThrow(Exception('Error fetching characters'));

    expect(()=> repositoryImpl.getCharacters(), throwsA(isA<Exception>()));
    verify(() => mockCharacterRemoteDataSource.getCharacters(),).called(1);

  });

}