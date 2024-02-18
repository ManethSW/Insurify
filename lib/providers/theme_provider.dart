import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:insurify/constant.dart';

class ThemeProvider extends ChangeNotifier {
  String _theme = 'dark';

  final Map<String, Color> _lightThemeColors = lightThemeColors;
  final Map<String, Color> _darkThemeColors = darkThemeColors;
  final Map<String, String> _lightThemeIconPaths = lightThemeIconPaths;
  final Map<String, String> _darkThemeIconPaths = darkThemeIconPaths;

  String get theme => _theme;

  Map<String, Color> get themeColors =>
      _theme == 'dark' ? _darkThemeColors : _lightThemeColors;

  Map<String, String> get themeIconPaths =>
      _theme == 'dark' ? _darkThemeIconPaths : _lightThemeIconPaths;

  void toggleTheme() {
    _theme = _theme == 'dark' ? 'light' : 'dark';
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness:
            _theme == 'dark' ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            _theme == 'dark' ? Brightness.light : Brightness.dark,
      ),
    );
    notifyListeners();
  }
}