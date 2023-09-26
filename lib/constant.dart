import 'package:flutter/material.dart';

const primaryColor = Color(0xFF24242B);
const secondaryColor = Color(0xFF1D1D22);

const buttonOneColor = Color(0xFF16161B);

const startUpBodyTextColor = Color(0x5FFFFFFF);

const kAccentColor = Color(0xFFE5E5E5);
const kTextColor = Color(0xFFFFFFFF);
const kTextLightColor = Color(0xFFA6A6A6);
const kTextDarkColor = Color(0xFF1D1D22);
const kTextDarkColor2 = Color(0xFF2D2D33);

//Create color maps
const Map<String, Color> darkThemeColors = {
  "whiteColor": Color(0xFFFFFFFF),
  "primaryColor": Color(0xFF24242B),
  "buttonOneColor": Color(0xFF16161B),

  "startUpBodyTextColor": Color(0x80FFFFFF),

  "textFieldBorderAndLabelColor": Color(0x80FFFFFF),
  "textFieldBackgroundColor": Color(0xFF1D1D22),
  "phontNumberSeperator": Color(0x40FFFFFF),
};

const Map<String, Color> lightThemeColors = {
  "whiteColor": Color(0xFF000000),
  "primaryColor": Color(0xFFFFFFFF),
  "buttonOneColor": Color(0xFFE1E1E2),

  "startUpBodyTextColor": Color(0x80000000),

  "textFieldBorderAndLabelColor": Color(0x80000000),
  "textFieldBackgroundColor": Color(0xFFF7F7F8),
  "phontNumberSeperator": Color(0x40000000),
};

const Map<String, String> darkThemeIconPaths = {
  "logo": "assets/icons/logo-small-dark.png",
  "fowardArrow": "assets/icons/forward-dark.svg",
  "backArrow": "assets/icons/backward-dark.svg",
};

const Map<String, String> lightThemeIconPaths = {
  "logo": "assets/icons/logo-small-light.png",
  "fowardArrow": "assets/icons/forward-light.svg",
  "backArrow": "assets/icons/backward-light.svg",
};