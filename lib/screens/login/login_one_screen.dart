import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:insurify/providers/theme_provider.dart';
import 'package:insurify/providers/user_provider.dart';
import 'package:insurify/screens/components/bottom_buttons.dart';
import 'package:insurify/screens/components/register_input_field.dart';
import 'package:insurify/screens/components/startup_screen_heading.dart';
import 'package:insurify/screens/login/login_two_screen.dart';

class LoginOneScreen extends StatefulWidget {
  const LoginOneScreen({Key? key}) : super(key: key);

  @override
  LoginOneScreenState createState() => LoginOneScreenState();
}

class LoginOneScreenState extends State<LoginOneScreen> {
  final TextEditingController phoneNoController = TextEditingController();
  late ThemeProvider themeProvider;
  late UserDataProvider userDataProvider;
  late bool isPhoneNoValid;
  late Color phoneNoValidationColor;
  late IconData phoneNoValidationIcon;

  @override
  void initState() {
    super.initState();
    setControllers();
    isPhoneNoValid = false;
    phoneNoValidationIcon = Icons.close_rounded;
    phoneNoValidationColor = Colors.grey;
  }

  @override
  void dispose() {
    phoneNoController.dispose();
    super.dispose();
  }

  void setControllers() {
    phoneNoController.text = '';
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

  void showSnackBar(BuildContext context, String message) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: themeProvider.themeColors["primary"],
        content: Text(
          message,
          style: TextStyle(
            color: themeProvider.themeColors["white"],
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: 'Inter',
          ),
        ),
        action: SnackBarAction(
          backgroundColor: themeProvider.themeColors["secondary"],
          label: 'OK',
          textColor: themeProvider.themeColors["white"],
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    userDataProvider = Provider.of<UserDataProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeProvider.themeColors["primary"],
        systemNavigationBarColor: themeProvider.themeColors["primary"],
      ),
    );
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    // width variable of screen
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
                      SizedBox(height: height * 0.125),
                      buildStartUpScreenHeading(context, 'Login'),
                      SizedBox(height: height * 0.075),
                      buildInputRow(
                        'Phone Number',
                        phoneNoValidationIcon,
                        phoneNoValidationColor,
                        buildBuildTextField(phoneNoController, '07XXXXXXXX',
                            true, 'Phone Number'),
                        context,
                        () {},
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
                  LoginTwoScreen(
                    phoneNo: phoneNoController.text,
                  ),
                  () async {
                    final localContext = context;
                    String jsonString =
                        await rootBundle.loadString('assets/data.json');
                    List<dynamic> usersData = jsonDecode(jsonString);

                    bool userExists = usersData.any(
                        (user) => user['phoneNo'] == phoneNoController.text);

                    if (isPhoneNoValid) {
                      if (phoneNoController.text ==
                              userDataProvider.userData.phoneNo ||
                          userExists) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    LoginTwoScreen(phoneNo: phoneNoController.text),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                        // ignore: use_build_context_synchronously
                        showSnackBar(localContext, 'User does not exist');
                      }
                    } else {
                      // ignore: use_build_context_synchronously
                      showSnackBar(
                          localContext, 'Please fill in a valid phone number');
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
