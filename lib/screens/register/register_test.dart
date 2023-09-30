import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurify/providers/user_provider.dart';
import 'package:insurify/screens/components/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:insurify/providers/theme_provider.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {
  late ThemeProvider themeProvider;
  late UserDataProvider userDataProvider;
  bool _isOpen = false;

  Image? profilePicture;
  File? profilePictureNew;
  final ValueNotifier<bool> updatePicture = ValueNotifier(false);

  late bool isFirstNameValid;
  late IconData firstNameValidationIcon;
  late Color firstNameValidationColor;

  final List<TextEditingController> textEditingControllers = List.generate(
    3,
    (_) => TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    if (userDataProvider.userData.profilePic != null) {
      profilePicture = userDataProvider.userData.profilePic;
    }
    isFirstNameValid = false;
    firstNameValidationIcon = Icons.close;
    firstNameValidationColor = Colors.grey;
  }

  @override
  void dispose() {
    for (final controller in textEditingControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void setControllers() {
    textEditingControllers[0].text = '';
    textEditingControllers[1].text = '';
    textEditingControllers[2].text = '';
  }

  void updateUserData() {
    userDataProvider.userData.fname = textEditingControllers[0].text;
    userDataProvider.userData.lname = textEditingControllers[1].text;
    userDataProvider.userData.email = textEditingControllers[2].text;
  }

  Widget buildBuildTextField(
      TextEditingController controller,
      String hintText,
      String label,
      bool isValid,
      IconData validationIcon,
      Color validationColor) {
    return TextField(
      cursorColor: themeProvider.themeColors["white"],
      cursorOpacityAnimates: true,
      controller: controller,
      style: TextStyle(
        color: themeProvider.themeColors["white"],
        fontSize: 12.5,
        fontFamily: 'Inter',
      ),
      onChanged: (value) {
        switch (label) {
          case 'Updated First Name':
            setState(() {
              if (value.isEmpty) {
                isFirstNameValid = false;
                firstNameValidationIcon = Icons.close_rounded;
                firstNameValidationColor = Colors.red;
              } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                isFirstNameValid = false;
                firstNameValidationIcon = Icons.close_rounded;
                firstNameValidationColor = Colors.red;
              } else {
                isFirstNameValid = true;
                firstNameValidationIcon = Icons.check;
                firstNameValidationColor = Colors.green;
              }
            });
            break;
        }
      },
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(0),
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: themeProvider.themeColors["white"]!.withOpacity(0.75),
          fontWeight: FontWeight.w400,
          fontSize: 12.5,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget buildBuildTextFieldContainer(
      TextEditingController controller,
      String hintText,
      bool textFieldTyping,
      String label,
      bool isValid,
      IconData validationIcon,
      Color validationColor) {
    return Container(
      height: 42.5,
      padding: const EdgeInsets.only(
          left: 16,
          right: 10,
          bottom: 0,
          top: 11.5), // Padding for the TextField
      decoration: BoxDecoration(
        color: themeProvider.themeColors["textFieldBackground"],
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: themeProvider.themeColors["textFieldBorderAndLabel"]!,
            width: 2),
      ),
      child: buildBuildTextField(controller, hintText, label, isValid,
          validationIcon, validationColor),
    );
  }

  Widget buildTextFieldLabel(String label) {
    return Positioned(
      top: -10,
      left: 17.5,
      child: Text(
        label,
        style: TextStyle(
          color: themeProvider.themeColors["textFieldBorderAndLabel"],
          fontWeight: FontWeight.w600,
          fontSize: 12.5,
          fontFamily: 'Inter',
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget buildTextFieldLabelBackground(double labelbackgroundwidth) {
    return Positioned(
      top: -0.5,
      left: 7.5,
      child: Container(
        height: 10,
        width: labelbackgroundwidth,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: themeProvider.themeColors["textFieldBackground"],
        // color: Colors.red,
      ),
    );
  }

  Widget buildInputRow(
      String label,
      TextEditingController controller,
      String hintText,
      double labelbackgroundwidth,
      bool isValid,
      IconData validationIcon,
      Color validationColor) {
    return Stack(
      alignment: Alignment.topLeft,
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          height: 47.5,
          padding: const EdgeInsets.only(
              left: 16, right: 10, bottom: 0), // Padding for the TextField
          decoration: BoxDecoration(
            color: themeProvider.themeColors["textFieldBackground"],
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: themeProvider.themeColors["textFieldBorderAndLabel"]!,
                width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: buildBuildTextField(
                  controller,
                  hintText,
                  label,
                  isValid,
                  validationIcon,
                  validationColor,
                ),
              ),
              Icon(
                validationIcon,
                size: 20,
                color: validationColor,
              )
            ],
          ),
        ),
        buildTextFieldLabelBackground(labelbackgroundwidth),
        buildTextFieldLabel(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    userDataProvider = Provider.of<UserDataProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              buildTopBar(context),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 95),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                        height: _isOpen ? 130 : 57.5,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        padding: const EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: themeProvider.themeColors["buttonOne"],
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
                                    "First Name",
                                    style: TextStyle(
                                      color: themeProvider.themeColors["white"]!
                                          .withOpacity(0.50),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.5,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    userDataProvider.userData.fname!,
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
                                margin: EdgeInsets.only(
                                    top: 70, right: 12, bottom: 12),
                                child: buildInputRow(
                                  'Updated First Name',
                                  textEditingControllers[0],
                                  'Enter your new first name',
                                  132.5,
                                  isFirstNameValid,
                                  firstNameValidationIcon,
                                  firstNameValidationColor,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isOpen = !_isOpen;
                                  });
                                },
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
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.easeInOut,
                                      turns: _isOpen ? 0.25 : 0.75,
                                      child: SvgPicture.asset(
                                        themeProvider
                                            .themeIconPaths["backArrow"]!,
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
