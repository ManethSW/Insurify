import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:insurify/providers/theme_provider.dart';

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
            themeProvider
                .themeColors["primary"]!,
            themeProvider.themeColors[
                "textFieldBackground"]!
          ],
          stops: const [0.4, 0.6],
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: themeProvider.themeColors["white"]!.withOpacity(0.5),
          fontWeight: FontWeight.w600,
          fontSize: 15,
          fontFamily: 'Inter',
        ),
      ),
    ),
  );
}

Widget buildInputRow(
    String label,
    IconData validationIcon,
    Color validationColor,
    Widget textField,
    BuildContext context,
    Function() chooseDate) {
  themeProvider = Provider.of<ThemeProvider>(context);
  return Stack(
    alignment: Alignment.topLeft,
    clipBehavior: Clip.none,
    children: [
      GestureDetector(
        onTap: chooseDate,
        child: Container(
          height: 47.5,
          padding: const EdgeInsets.symmetric(horizontal: 17.5),
          decoration: BoxDecoration(
            color: themeProvider.themeColors["textFieldBackground"],
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: themeProvider.themeColors["white"]!.withOpacity(0.5),
                width: 2),
          ),
          child: label == "Phone Number"
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
                            color:themeProvider.themeColors["white"]!.withOpacity(0.25),
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
                    label == "Date of Birth"
                        ? Text(
                            "18+",
                            style: TextStyle(
                              color: validationColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          )
                        : Icon(
                            validationIcon,
                            size: 20,
                            color: validationColor,
                          )
                  ],
                ),
        ),
      ),
      buildTextFieldLabel(label, context),
    ],
  );
}
