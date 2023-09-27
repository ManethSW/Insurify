import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurify/screens/components/build_bottom_buttons.dart';
import 'package:insurify/screens/components/startup_screen_heading.dart';
import 'package:insurify/screens/login/login_two_screen.dart';
import 'package:insurify/screens/register/register_two_screen.dart';
import 'package:insurify/screens/startup/startup_screen.dart';

class LoginOneScreen extends StatefulWidget {
  const LoginOneScreen({Key? key}) : super(key: key);

  @override
  LoginOneScreenState createState() => LoginOneScreenState();
}

class LoginOneScreenState extends State<LoginOneScreen> {
  final TextEditingController phoneNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setControllers();
  }

  @override
  void dispose() {
    phoneNoController.dispose();
    super.dispose();
  }

  void setControllers() {
    phoneNoController.text = '';
  }

  Widget buildBuildTextField(
      TextEditingController controller, String hintText, bool textFieldTyping) {
    return TextField(
      cursorColor: globalProvider.themeColors["white"],
      cursorOpacityAnimates: true,
      controller: controller,
      style: TextStyle(
        color: globalProvider.themeColors["white"],
        fontSize: 14,
        fontFamily: 'Inter',
      ),
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
          color: globalProvider.themeColors["white"],
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget buildBuildTextFieldContainer(
      TextEditingController controller, String hintText, bool textFieldTyping) {
    return Container(
      height: 47.5,
      padding: const EdgeInsets.only(
          left: 16,
          right: 10,
          bottom: 0,
          top: 13.75), // Padding for the TextField
      decoration: BoxDecoration(
        color: globalProvider.themeColors["textFieldBackground"],
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: globalProvider.themeColors["textFieldBorderAndLabel"]!,
            width: 2),
      ),
      child: buildBuildTextField(controller, hintText, textFieldTyping),
    );
  }

  Widget buildTextFieldLabel(String label) {
    return Positioned(
      top: -8.5,
      left: 17.5,
      child: Text(
        label,
        style: TextStyle(
          color: globalProvider.themeColors["textFieldBorderAndLabel"],
          fontWeight: FontWeight.w600,
          fontSize: 15,
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
        color: globalProvider.themeColors["textFieldBackground"],
        // color: Colors.red,
      ),
    );
  }

  Widget buildInputRowPhoneNo(String label, TextEditingController controller,
      String hintText, double labelbackgroundwidth, bool textFieldTyping) {
    return Flexible(
      child: Stack(
        alignment: Alignment.topLeft,
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            height: 47.5,
            padding: const EdgeInsets.only(
                left: 16, right: 10, bottom: 0), // Padding for the TextField
            decoration: BoxDecoration(
              color: globalProvider.themeColors["textFieldBackground"],
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: globalProvider.themeColors["textFieldBorderAndLabel"]!,
                  width: 2),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/flag.png',
                ),
                const SizedBox(width: 10),
                Text(
                  '+94',
                  style: TextStyle(
                    color: globalProvider.themeColors["white"],
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 2,
                  height: 15,
                  color: globalProvider.themeColors["phontNumberSeperator"],
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: buildBuildTextField(
                      controller, hintText, textFieldTyping),
                ),
              ],
            ),
          ),
          buildTextFieldLabelBackground(labelbackgroundwidth),
          buildTextFieldLabel(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  globalProvider.themeIconPaths["smallLogo"]!,
                  height: 38,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 31, right: 31),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: height * 0.125),
                      buildStartUpScreenHeading(context, 'Login'),
                      SizedBox(height: height * 0.075),
                      buildInputRowPhoneNo('Phone Number', phoneNoController,
                          '07XXXXXXXX', 120, true),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 160,
                left: 31,
                right: 31,
                child: TextButton(
                  onPressed: () {
                    globalProvider.toggleTheme();
                  },
                  child: const Text('Change Theme'),
                ),
              ),
              Positioned(
                bottom: 31,
                left: 31,
                right: 31,
                child: buildBackAndNextButtons(
                  context,
                  width,
                  StartupScreen(),
                  const LoginTwoScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
