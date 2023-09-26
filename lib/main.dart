import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insurify/screens/register/register_test.dart';

import 'package:insurify/screens/startup/startup_screen.dart';
import 'package:insurify/screens/register/register_one_screen.dart';
import 'package:insurify/constant.dart';
import 'package:insurify/screens/theme/dark_theme.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      systemNavigationBarColor: primaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp()); // Start your app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insurify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: RegisterOneScreen(),
    );
  }
}
