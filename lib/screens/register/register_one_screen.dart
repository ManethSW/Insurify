import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insurify/main.dart';
import 'package:insurify/screens/components/build_bottom_buttons.dart';
import 'package:insurify/screens/register/register_two_screen.dart';
import 'package:insurify/screens/startup/startup_screen.dart';
import 'package:provider/provider.dart';

class RegisterOneScreen extends StatefulWidget {
  const RegisterOneScreen({Key? key}) : super(key: key);

  @override
  RegisterOneScreenState createState() => RegisterOneScreenState();
}

class RegisterOneScreenState extends State<RegisterOneScreen> {
  late GlobalProvider globalProvider;
  final TextEditingController controller = TextEditingController();
  final List<TextEditingController> textEditingControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    setControllers();
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
    textEditingControllers[5].text = 'Male';
  }

  Widget buildBuildTextField(
      TextEditingController controller, String hintText, bool textFieldTyping) {
    return TextField(
      cursorColor: globalProvider.themeColors["whiteColor"],
      cursorOpacityAnimates: true,
      controller: controller,
      style: TextStyle(
        color: globalProvider.themeColors["whiteColor"],
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
          color: globalProvider.themeColors["whiteColor"],
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
        color: globalProvider.themeColors["textFieldBackgroundColor"],
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: globalProvider.themeColors["textFieldBorderAndLabelColor"]!,
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
          color: globalProvider.themeColors["textFieldBorderAndLabelColor"],
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
        color: globalProvider.themeColors["textFieldBackgroundColor"],
        // color: Colors.red,
      ),
    );
  }

  Widget buildInputRow(String label, TextEditingController controller,
      String hintText, double labelbackgroundwidth, bool textFieldTyping) {
    return Flexible(
      child: Stack(
        alignment: Alignment.topLeft,
        clipBehavior: Clip.none,
        children: <Widget>[
          buildBuildTextFieldContainer(controller, hintText, textFieldTyping),
          buildTextFieldLabelBackground(labelbackgroundwidth),
          buildTextFieldLabel(label),
        ],
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
              color: globalProvider.themeColors["textFieldBackgroundColor"],
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: globalProvider
                      .themeColors["textFieldBorderAndLabelColor"]!,
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
                    color: globalProvider.themeColors["whiteColor"],
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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(textEditingControllers[4].text),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        textEditingControllers[4].text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Widget buildDoBInput(String label, TextEditingController controller,
      String hintText, double labelbackgroundwidth, bool textFieldTyping) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          selectDate(context);
        },
        child: Stack(
          alignment: Alignment.topLeft,
          clipBehavior: Clip.none,
          children: <Widget>[
            buildBuildTextFieldContainer(controller, hintText, textFieldTyping),
            buildTextFieldLabelBackground(labelbackgroundwidth),
            buildTextFieldLabel(label),
            Positioned(
              right: 15,
              top: 15,
              child: Icon(
                Icons.calendar_today_outlined,
                color: globalProvider.themeColors["whiteColor"],
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGenderInput(String label, TextEditingController controller,
      String hintText, double labelbackgroundwidth, bool textFieldTyping) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          // openDropDown(context);
        },
        child: Stack(
          alignment: Alignment.topLeft,
          clipBehavior: Clip.none,
          children: <Widget>[
            buildBuildTextFieldContainer(controller, hintText, textFieldTyping),
            buildTextFieldLabelBackground(labelbackgroundwidth),
            buildTextFieldLabel(label),
            Positioned(
              right: 15,
              top: 15,
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: globalProvider.themeColors["whiteColor"],
                size: 20,
              ),
            ),
          ],
        ),
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
                  globalProvider.themeIconPaths["logo"]!,
                  height: 38,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 31, right: 31),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.125),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: globalProvider.themeColors["whiteColor"],
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: height * 0.1),
                      buildInputRow('First Name', textEditingControllers[0],
                          'Enter your first name', 95, true),
                      SizedBox(height: height * 0.06),
                      buildInputRow('Last Name', textEditingControllers[1],
                          'Enter your last name', 93, true),
                      SizedBox(height: height * 0.06),
                      buildInputRow('Email', textEditingControllers[2],
                          'Enter your email', 60, true),
                      SizedBox(height: height * 0.06),
                      buildInputRowPhoneNo('Phone Number',
                          textEditingControllers[3], '07XXXXXXXX', 120, true),
                      SizedBox(height: height * 0.06),
                      Row(
                        children: [
                          buildDoBInput(
                              'Date of Birth',
                              textEditingControllers[4],
                              '01/01/2023',
                              105,
                              false),
                          const SizedBox(width: 20),
                          buildGenderInput('Gender', textEditingControllers[5],
                              'Male', 70, false),
                        ],
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
                  const StartupScreen(),
                  const RegisterTwoScreen(),
                  globalProvider.themeColors["buttonOneColor"]!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
