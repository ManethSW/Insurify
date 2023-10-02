// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:insurify/providers/theme_provider.dart';
import 'package:insurify/providers/user_provider.dart';
import 'package:insurify/screens/components/bottom_buttons.dart';
import 'package:insurify/screens/components/register_input_field.dart';
import 'package:insurify/screens/register/register_two_screen.dart';

class RegisterOneScreen extends StatefulWidget {
  const RegisterOneScreen({Key? key}) : super(key: key);

  @override
  RegisterOneScreenState createState() => RegisterOneScreenState();
}

class RegisterOneScreenState extends State<RegisterOneScreen> {
  late ThemeProvider themeProvider;
  late bool isFirstNameValid;
  late Color firstNameValidationColor;
  late IconData firstNameValidationIcon;
  late bool isLastNameValid;
  late Color lastNameValidationColor;
  late IconData lastNameValidationIcon;
  late bool isEmailValid;
  late Color emailValidationColor;
  late IconData emailValidationIcon;
  late bool isPhoneNoValid;
  late Color phoneNoValidationColor;
  late IconData phoneNoValidationIcon;
  late bool isDobValid;
  late Color dobValidationColor;
  late IconData dobValidationIcon;

  UserData userData = UserData(
      fname: '',
      lname: '',
      email: '',
      phoneNo: '',
      dob: DateTime.now(),
      policies: []);
  final List<TextEditingController> textEditingControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    setControllers();
    isFirstNameValid = false;
    firstNameValidationIcon = Icons.close_rounded;
    firstNameValidationColor = Colors.grey;
    isLastNameValid = false;
    lastNameValidationIcon = Icons.close_rounded;
    lastNameValidationColor = Colors.grey;
    isEmailValid = false;
    emailValidationIcon = Icons.close_rounded;
    emailValidationColor = Colors.grey;
    isPhoneNoValid = false;
    phoneNoValidationIcon = Icons.close_rounded;
    phoneNoValidationColor = Colors.grey;
    isDobValid = false;
    dobValidationIcon = Icons.close_rounded;
    dobValidationColor = Colors.grey;
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
    textEditingControllers[3].text = '';
    textEditingControllers[4].text =
        "${DateTime.now().toLocal()}".split(' ')[0];
  }

  void updateUserData() {
    userData.fname = textEditingControllers[0].text;
    userData.lname = textEditingControllers[1].text;
    userData.email = textEditingControllers[2].text;
    userData.phoneNo = textEditingControllers[3].text;
    userData.dob = DateTime.parse(textEditingControllers[4].text);
  }

  Widget buildBuildTextField(TextEditingController controller, String hintText,
      bool textFieldTyping, String label) {
    return TextField(
      cursorColor: themeProvider.themeColors["white"],
      cursorOpacityAnimates: true,
      controller: controller,
      style: TextStyle(
        color: themeProvider.themeColors["white"],
        fontSize: 14,
        fontFamily: 'Inter',
      ),
      onChanged: (value) {
        switch (label) {
          case 'First Name':
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
                firstNameValidationIcon = Icons.check_rounded;
                firstNameValidationColor = Colors.green;
              }
            });
            break;
          case 'Last Name':
            setState(() {
              if (value.isEmpty) {
                isLastNameValid = false;
                lastNameValidationIcon = Icons.close_rounded;
                lastNameValidationColor = Colors.red;
              } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                isLastNameValid = false;
                lastNameValidationIcon = Icons.close_rounded;
                lastNameValidationColor = Colors.red;
              } else {
                isLastNameValid = true;
                lastNameValidationIcon = Icons.check_rounded;
                lastNameValidationColor = Colors.green;
              }
            });
            break;
          case 'Email':
            setState(() {
              if (value.isEmpty) {
                isEmailValid = false;
                emailValidationIcon = Icons.close_rounded;
                emailValidationColor = Colors.red;
              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                isEmailValid = false;
                emailValidationIcon = Icons.close_rounded;
                emailValidationColor = Colors.red;
              } else {
                isEmailValid = true;
                emailValidationIcon = Icons.check_rounded;
                emailValidationColor = Colors.green;
              }
            });
            break;
          case 'Phone Number':
            setState(() {
              if (value.isEmpty) {
                isPhoneNoValid = false;
                phoneNoValidationIcon = Icons.close_rounded;
                phoneNoValidationColor = Colors.red;
              } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                isPhoneNoValid = false;
                phoneNoValidationIcon = Icons.close_rounded;
                phoneNoValidationColor = Colors.red;
              } else {
                isPhoneNoValid = true;
                phoneNoValidationIcon = Icons.check_rounded;
                phoneNoValidationColor = Colors.green;
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
        enabled: textFieldTyping,
        hintStyle: TextStyle(
          color: themeProvider.themeColors["white"]!.withOpacity(0.75),
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(textEditingControllers[4].text),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.parse(textEditingControllers[4].text),
    );
    if (picked != null) {
      if (picked
          .isAfter(DateTime.now().subtract(const Duration(days: 365 * 18)))) {
        setState(() {
          isDobValid = false;
          dobValidationIcon = Icons.close_rounded;
          dobValidationColor = Colors.red;
          textEditingControllers[4].text = "${picked.toLocal()}".split(' ')[0];
        });
      } else {
        setState(() {
          isDobValid = true;
          dobValidationIcon = Icons.check_rounded;
          dobValidationColor = Colors.green;
          textEditingControllers[4].text = "${picked.toLocal()}".split(' ')[0];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeProvider.themeColors["primary"],
        systemNavigationBarColor: themeProvider.themeColors["primary"],
      ),
    );
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final double width =
        MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                child: Image.asset(
                  themeProvider.themeIconPaths["smallLogo"]!,
                  height: 38,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 31, right: 31),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.1),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: themeProvider.themeColors["white"],
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: height * 0.075),
                      buildInputRow(
                        'First Name',
                        firstNameValidationIcon,
                        firstNameValidationColor,
                        buildBuildTextField(textEditingControllers[0],
                            'Enter your first name', true, 'First Name'),
                        context,
                        () {},
                      ),
                      SizedBox(height: height * 0.05),
                      buildInputRow(
                        'Last Name',
                        lastNameValidationIcon,
                        lastNameValidationColor,
                        buildBuildTextField(textEditingControllers[1],
                            'Enter your last name', true, 'Last Name'),
                        context,
                        () {},
                      ),
                      SizedBox(height: height * 0.05),
                      buildInputRow(
                        'Email',
                        emailValidationIcon,
                        emailValidationColor,
                        buildBuildTextField(textEditingControllers[2],
                            'Enter your email', true, 'Email'),
                        context,
                        () {},
                      ),
                      SizedBox(height: height * 0.05),
                      buildInputRow(
                        'Phone Number',
                        phoneNoValidationIcon,
                        phoneNoValidationColor,
                        buildBuildTextField(textEditingControllers[3],
                            '07XXXXXXXX', true, 'Phone Number'),
                        context,
                        () {},
                      ),
                      SizedBox(height: height * 0.05),
                      buildInputRow(
                        'Date of Birth',
                        dobValidationIcon,
                        dobValidationColor,
                        buildBuildTextField(textEditingControllers[4],
                            '01/01/2023', false, 'Date of Birth'),
                        context,
                        () {
                          selectDate(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 31,
                left: 31,
                right: 31,
                child: buildBackAndNextButtons(
                  context,
                  width,
                  RegisterTwoScreen(userData: userData),
                  () async {
                    String jsonString =
                        await rootBundle.loadString('assets/data.json');
                    List<dynamic> usersData = jsonDecode(jsonString);

                    bool userExists = usersData.any((user) =>
                        user['phoneNo'] == textEditingControllers[3].text);
                    if (userExists) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: themeProvider.themeColors["primary"],
                          content: Text(
                            'Phone number is already registered',
                            style: TextStyle(
                              color: themeProvider.themeColors["white"],
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          ),
                          action: SnackBarAction(
                            backgroundColor:
                                themeProvider.themeColors["secondary"],
                            label: 'OK',
                            textColor: themeProvider.themeColors["white"],
                            onPressed: () {},
                          ),
                        ),
                      );
                    }
                    else if (isFirstNameValid &&
                        isLastNameValid &&
                        isEmailValid &&
                        isPhoneNoValid &&
                        isDobValid) {
                      updateUserData();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  RegisterTwoScreen(userData: userData),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var tween = Tween(begin: begin, end: end);
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: themeProvider.themeColors["primary"],
                          content: Text(
                            'Please fill in all the required fields.',
                            style: TextStyle(
                              color: themeProvider.themeColors["white"],
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          ),
                          action: SnackBarAction(
                            backgroundColor:
                                themeProvider.themeColors["secondary"],
                            label: 'OK',
                            textColor: themeProvider.themeColors["white"],
                            onPressed: () {},
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
