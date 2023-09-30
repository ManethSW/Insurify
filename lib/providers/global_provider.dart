import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier {
  String currentScreen = 'home';

  void setCurrentScreen(newCurrentScreen) {
    currentScreen = newCurrentScreen;
    notifyListeners();
  }
}
