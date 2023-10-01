import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurify/providers/theme_provider.dart';
import 'package:provider/provider.dart';

late ThemeProvider themeProvider;
Widget buildTextFieldLabel(String label, BuildContext context) {
  themeProvider = Provider.of<ThemeProvider>(context);
  return Positioned(
    top: -7.5,
    left: 7.5,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            themeProvider.themeColors["primary"]!,
            themeProvider.themeColors["textFieldBackground"]!
          ],
          stops: const [0.5, 0.5],
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: themeProvider.themeColors["textFieldBorderAndLabel"],
          fontWeight: FontWeight.w600,
          fontSize: 12.5,
          fontFamily: 'Inter',
        ),
      ),
    ),
  );
}

Widget buildInputRow(String label, Widget textField, BuildContext context) {
  themeProvider = Provider.of<ThemeProvider>(context);
  return Stack(
    alignment: Alignment.topLeft,
    clipBehavior: Clip.none,
    children: [
      Container(
        height: 42.5,
        padding: const EdgeInsets.symmetric(horizontal: 17.5),
        decoration: BoxDecoration(
          color: themeProvider.themeColors["textFieldBackground"],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: themeProvider.themeColors["textFieldBorderAndLabel"]!,
              width: 1),
        ),
        child: Center(
          child: textField,
        ),
      ),
      buildTextFieldLabel(label, context),
    ],
  );
}

Widget buildEditRow(
    String label,
    String currentValue,
    bool isOpen,
    VoidCallback onToggleOpen,
    Widget textField,
    BuildContext context) {
  themeProvider = Provider.of<ThemeProvider>(context);
  return AnimatedContainer(
    duration: const Duration(milliseconds: 350),
    curve: Curves.easeInOut,
    height: label == "Phone Number"
        ? 130
        : isOpen
            ? 130
            : 57.5,
    padding: const EdgeInsets.only(left: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: themeProvider.themeColors["secondary"],
    ),
    child: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: 55,
          margin: const EdgeInsets.only(top: 11.25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: themeProvider.themeColors["white"]!.withOpacity(0.50),
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                currentValue,
                style: TextStyle(
                  color: themeProvider.themeColors["white"],
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                  fontFamily: 'Inter',
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            height: 47.5,
            margin: const EdgeInsets.only(top: 70, right: 12, bottom: 12),
            child: buildInputRow(label, textField, context),
          ),
        ),
        label == "Phone Number"
            ? Container()
            : Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: onToggleOpen,
                  child: Container(
                    width: 45,
                    height: 47.5,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeProvider.themeColors["primary"],
                    ),
                    child: Center(
                      child: AnimatedRotation(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                        turns: isOpen ? 0.25 : 0.75,
                        child: SvgPicture.asset(
                          themeProvider.themeIconPaths["backArrow"]!,
                          width: 10,
                          height: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    ),
  );
}
