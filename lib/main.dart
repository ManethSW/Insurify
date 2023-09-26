import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:insurify/screens/startup/startup_screen.dart';
import 'package:insurify/screens/register/register_one_screen.dart';
import 'package:insurify/constant.dart';

class GlobalProvider extends ChangeNotifier {
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
    notifyListeners();
  }
}

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      systemNavigationBarColor: primaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: GlobalProvider()),
    ],
    child: const MyApp(),
  ));
  // Start your app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final globalProvider = Provider.of<GlobalProvider>(context);
    return MaterialApp(
      title: 'Insurify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: globalProvider.themeColors["primaryColor"],
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: RegisterOneScreen(),
    );
  }
}
