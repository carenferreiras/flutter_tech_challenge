import 'package:flutter_tech_challenge/src/modules/marvel_characters/marvel_characters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockGetCharactersUsecase extends Mock implements GetCharactersUsecase {}

void main() {
  late MockGetCharactersUsecase mockGetCharactersUsecase;
  late CharacterProvider characterProvider;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockGetCharactersUsecase = MockGetCharactersUsecase();
    characterProvider = CharacterProvider(mockGetCharactersUsecase);
  });

  group('CharacterProvider', () {
    test('Should start with an empty character list and not loading', () {
      expect(characterProvider.characters, isEmpty);
      expect(characterProvider.isLoading, false);
    });

    test('Should fetch characters and update the list', () async {
      // Arrange
      final characters = [
        Character(id: 1, name: 'Spider-Man', description: 'A hero', imageUrl: 'url1'),
        Character(id: 2, name: 'Iron Man', description: 'A billionaire', imageUrl: 'url2'),
      ];
      when(() => mockGetCharactersUsecase()).thenAnswer((_) async => characters);

      // Act
      await characterProvider.fetchCharacters();

      // Assert
      expect(characterProvider.isLoading, false);
      expect(characterProvider.characters, equals(characters));
      expect(characterProvider.filteredCharacters, equals(characters));
    });

    test('Should filter characters by name', () async {
      final characters = [
        Character(id: 1, name: 'Spider-Man', description: 'A hero', imageUrl: 'url1'),
        Character(id: 2, name: 'Iron Man', description: 'A billionaire', imageUrl: 'url2'),
      ];
      when(() => mockGetCharactersUsecase()).thenAnswer((_) async => characters);

      await characterProvider.fetchCharacters();
      
      characterProvider.filterCharactersByName('spider');
      
      expect(characterProvider.filteredCharacters.length, 1);
      expect(characterProvider.filteredCharacters.first.name, 'Spider-Man');
    });

    test('Should save and load character click timestamps', () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('click_time_1', DateTime.now().toIso8601String());

      final characters = [
        Character(id: 1, name: 'Spider-Man', description: 'A hero', imageUrl: 'url1'),
      ];

      when(() => mockGetCharactersUsecase()).thenAnswer((_) async => characters);

      await characterProvider.fetchCharacters();

      await characterProvider.incrementCharacterClick(1);

      expect(characterProvider.characterLastClick[1], isNotNull);
    });
  });
}