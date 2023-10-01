import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurify/providers/theme_provider.dart';
import 'package:provider/provider.dart';

late ThemeProvider themeProvider;
Widget buildTextFieldLabel(String label, BuildContext context) {
  themeProvider = Provider.of<ThemeProvider>(context);
  return Positioned(
    top: -7.5,
    left: 10,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            themeProvider.themeColors["secondary"]!,
            themeProvider.themeColors["textFieldBackground"]!
          ],
          stops: const [0.3, 1.0],
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

Widget buildInputRow(String label, IconData validationIcon,
    Color validationColor, Widget textField, BuildContext context) {
  themeProvider = Provider.of<ThemeProvider>(context);
  return Stack(
    alignment: Alignment.topLeft,
    clipBehavior: Clip.none,
    children: [
      Container(
        height: 47.5,
        padding: const EdgeInsets.symmetric(horizontal: 17.5),
        decoration: BoxDecoration(
          color: themeProvider.themeColors["textFieldBackground"],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: themeProvider.themeColors["textFieldBorderAndLabel"]!,
              width: 2),
        ),
        child: label == "Updated Phone Number"
            ? Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/flag.png',
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '+94',
                          style: TextStyle(
                            color: themeProvider.themeColors["white"],
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 2,
                          height: 15,
                          color:
                              themeProvider.themeColors["phontNumberSeperator"],
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: textField),
                      ],
                    ),
                  ),
                  Icon(
                    validationIcon,
                    size: 20,
                    color: validationColor,
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(child: textField),
                  Icon(
                    validationIcon,
                    size: 20,
                    color: validationColor,
                  )
                ],
              ),
      ),
      buildTextFieldLabel(label, context),
    ],
  );
}

Widget buildEditRow(
    String label,
    String editingLabel,
    IconData validationIcon,
    Color validationColor,
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
            child: buildInputRow(editingLabel, validationIcon, validationColor,
                textField, context),
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
