import 'package:flutter/material.dart';

Widget buildStartUpScreenHeading(String headingText) {
  return Text(
    headingText,
    style: const TextStyle(
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.w600,
      fontSize: 30,
      fontFamily: 'Inter',
    ),
  );
}
