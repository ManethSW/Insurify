import 'package:flutter/material.dart';
import 'package:insurify/providers/global_provider.dart';
import 'package:insurify/providers/user_provider.dart';
import 'package:insurify/screens/startup/startup_screen.dart';
import 'package:provider/provider.dart';

import 'package:insurify/providers/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeProvider()),
        ChangeNotifierProvider.value(value: GlobalProvider()),
        ChangeNotifierProvider.value(value: UserDataProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Insurify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: themeProvider.themeColors["primary"],
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: const StartupScreen(),
    );
  }
}
