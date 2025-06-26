import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool isDarkMode = false;
  String difficulty = 'easy';
  bool noBackspace = false;
  bool oneShot = false;
  bool invisibleInput = false;

  void toggleDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }

  void setDifficulty(String? value) {
    if (value != null) {
      difficulty = value;
      notifyListeners();
    }
  }

  void setNoBackspace(bool value) {
    noBackspace = value;
    notifyListeners();
  }

  void setOneShot(bool value) {
    oneShot = value;
    notifyListeners();
  }

  void setInvisibleInput(bool value) {
    invisibleInput = value;
    notifyListeners();
  }
} 