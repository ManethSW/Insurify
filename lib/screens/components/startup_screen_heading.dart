import 'package:flutter/material.dart';
import 'package:insurify/main.dart';
import 'package:provider/provider.dart';

Widget buildStartUpScreenHeading(BuildContext context, String headingText) {
  final GlobalProvider globalProvider = Provider.of<GlobalProvider>(context);
  return Text(
    headingText,
    style: TextStyle(
      color: globalProvider.themeColors["white"],
      fontWeight: FontWeight.w600,
      fontSize: 30,
      fontFamily: 'Inter',
    ),
  );
}
