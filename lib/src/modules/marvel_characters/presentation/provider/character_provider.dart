import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../marvel_characters.dart';

class CharacterProvider with ChangeNotifier {
  final GetCharactersUsecase getCharactersUseCase;
  List<Character> characters = [];
  List<Character> filteredCharacters = [];
  Map<int, DateTime> characterLastClick = {};
  bool isLoading = false;

  CharacterProvider(this.getCharactersUseCase);

  Future<void> fetchCharacters({String? nameFilter}) async {
    isLoading = true;
    notifyListeners();
    try {
      characters = await getCharactersUseCase();
      filteredCharacters = characters;
      await _loadClickTimestamps();
    } catch (e) {
      throw Exception('Error fetching characters: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterCharactersByName(String name) {
    if (name.isEmpty) {
      filteredCharacters = characters;
    } else {
      filteredCharacters = characters
          .where((character) =>
              character.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

 Future<void> incrementCharacterClick(int characterId) async {
  characterLastClick[characterId] = DateTime.now();
  await _saveClickTimestamps(); 
  notifyListeners();
}

 List<Character> getLastClickedCharacters() {
  final clickedCharacters = characters.where((character) {
    return characterLastClick.containsKey(character.id);
  }).toList();

  clickedCharacters.sort((a, b) {
    DateTime aTime = characterLastClick[a.id] ?? DateTime(1970);
    DateTime bTime = characterLastClick[b.id] ?? DateTime(1970);
    return bTime.compareTo(aTime);
  });

  final notClickedCharacters = characters.where((character) {
    return !characterLastClick.containsKey(character.id);
  }).toList();

  return clickedCharacters + notClickedCharacters;
}

  Future<void> _saveClickTimestamps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var entry in characterLastClick.entries) {
      await prefs.setString('click_time_${entry.key}', entry.value.toIso8601String());
    }
  }

  Future<void> _loadClickTimestamps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var character in characters) {
      String? timeStr = prefs.getString('click_time_${character.id}');
      if (timeStr != null) {
        characterLastClick[character.id] = DateTime.parse(timeStr);
      }
    }
    notifyListeners();
  }
}