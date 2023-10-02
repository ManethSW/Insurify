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
  "white": Color(0xFFFFFFFF),
  "primary": Color(0xFF24242B),
  "secondary": Color(0xFF16161B),
  "navigationBackground": Color(0x8016161B),
  "navigationActive": Color(0xFF24242B),
  "startUpBodyText": Color(0x80FFFFFF),
  "textFieldBackground": Color(0xFF1D1D22),
};

const Map<String, Color> lightThemeColors = {
  "white": Color(0xFF24242B),
  "primary": Color(0xFFFFFFFF),
  "secondary": Color(0xFFE1E1E2),
  "navigationBackground": Color(0x80E1E1E2),
  "navigationActive": Color(0xFFFFFFFF),
  "startUpBodyText": Color(0x80000000),
  "textFieldBackground": Color(0xFFF7F7F8),
};

const Map<String, String> darkThemeIconPaths = {
  "mainLogo": "assets/icons/logo-main-dark.png",
  "smallLogo": "assets/icons/logo-small-dark.png",
  "fowardArrow": "assets/icons/forward-dark.svg",
  "backArrow": "assets/icons/backward-dark.svg",
  "menu": "assets/icons/menu-dark.svg",
  "active": "assets/icons/active-dark.svg",
  "inactive": "assets/icons/inactive-dark.svg",
  "expire": "assets/icons/expire-dark.svg",
  "basicInsurance": "assets/icons/basic-insurance-dark.svg",
  "forwardArrowHead": "assets/icons/forward-arrow-head-dark.svg",
  "profile": "assets/icons/profile-dark.png",
  "home": "assets/icons/home-dark.png",
  "plus": "assets/icons/plus-dark.png",
  "blog": "assets/icons/blog-dark.png",
  "signout": "assets/icons/signout-dark.png",
  "homePage": "assets/images/home-page-dark.png",
  "addInsurancePage": "assets/images/add-insurance-page-dark.png",
  "profilePage": "assets/images/profile-page-dark.png",
  "blogPage": "assets/images/blog-page-dark.png",
  "darkMode": "assets/icons/moon-dark.svg",
  "lightMode": "assets/icons/sun-dark.svg"
};

const Map<String, String> lightThemeIconPaths = {
  "mainLogo": "assets/icons/logo-main-light.png",
  "smallLogo": "assets/icons/logo-small-light.png",
  "fowardArrow": "assets/icons/forward-light.svg",
  "backArrow": "assets/icons/backward-light.svg",
  "menu": "assets/icons/menu-light.svg",
  "active": "assets/icons/active-light.svg",
  "inactive": "assets/icons/inactive-light.svg",
  "expire": "assets/icons/expire-light.svg",
  "basicInsurance": "assets/icons/basic-insurance-light.svg",
  "forwardArrowHead": "assets/icons/forward-arrow-head-light.svg",
  "profile": "assets/icons/profile-light.png",
  "home": "assets/icons/home-light.png",
  "plus": "assets/icons/plus-light.png",
  "blog": "assets/icons/blog-light.png",
  "signout": "assets/icons/signout-light.png",
  "homePage": "assets/images/home-page-light.png",
  "addInsurancePage": "assets/images/add-insurance-page-light.png",
  "profilePage": "assets/images/profile-page-light.png",
  "blogPage": "assets/images/blog-page-light.png",
  "darkMode": "assets/icons/moon-light.svg",
  "lightMode": "assets/icons/sun-light.svg"
};