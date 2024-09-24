import 'package:flutter_tech_challenge/src/modules/marvel_characters/marvel_characters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late GetCharactersUsecase usecase;
  late MockCharacterRepository mockCharacterRepository;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    usecase = GetCharactersUsecase(mockCharacterRepository);
  });

  final testCharacters = [
    Character(
      id: 1,
      name: 'Spider-Man',
      description: 'Friendly neighborhood Spider-Man.',
      imageUrl: 'http://example.com/spiderman.jpg',
    ),
    Character(
      id: 2,
      name: 'Iron Man',
      description: 'Genius billionaire Tony Stark.',
      imageUrl: 'http://example.com/ironman.jpg',
    ),
  ];

  test('should get characters from the repository', () async {
    when(() => mockCharacterRepository.getCharacters())
        .thenAnswer((_) async => testCharacters);

    final result = await usecase();

    expect(result, testCharacters);
    verify(() => mockCharacterRepository.getCharacters()).called(1);
    verifyNoMoreInteractions(mockCharacterRepository);
  });

  test('should throw an exception when repository throws', () async {
    when(() => mockCharacterRepository.getCharacters()).thenThrow(Exception('Error'));

    expect(() => usecase(), throwsA(isA<Exception>()));
    verify(() => mockCharacterRepository.getCharacters()).called(1);
    verifyNoMoreInteractions(mockCharacterRepository);
  });
}