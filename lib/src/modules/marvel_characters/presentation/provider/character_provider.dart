import 'package:flutter/material.dart';
import 'package:flutter_tech_challenge/src/modules/marvel_characters/marvel_characters.dart';

class CharacterProvider with ChangeNotifier {
  final CharacterRepositoryImpl repositoryImpl;

  CharacterProvider(this.repositoryImpl);

  List<CharacterModel>? _characteres;
  bool _isLoading = false;
  String? _errorMessage;

  List<CharacterModel>? get characters => _characteres;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCaracters() async {
    _isLoading = true;

    notifyListeners();

    try {
      _characteres = await repositoryImpl.getCharacteres();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }
}
