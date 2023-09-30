import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:insurify/providers/theme_provider.dart';

Widget buildStartUpScreenHeading(BuildContext context, String headingText) {
  final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
  return Text(
    headingText,
    style: TextStyle(
      color: themeProvider.themeColors["white"],
      fontWeight: FontWeight.w600,
      fontSize: 30,
      fontFamily: 'Inter',
    ),
  );
}
