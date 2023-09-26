import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insurify/screens/components/build_bottom_buttons.dart';
import 'package:insurify/screens/register/register_two_screen.dart';
import 'package:insurify/screens/startup/startup_screen.dart';

class RegisterOneScreen extends StatefulWidget {
  const RegisterOneScreen({Key? key}) : super(key: key);

  @override
  RegisterOneScreenState createState() => RegisterOneScreenState();
}

class RegisterOneScreenState extends State<RegisterOneScreen> {
  final TextEditingController controller = TextEditingController();
  final List<TextEditingController> textEditingControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  List<String> genderOptions = ['Male', 'Female'];
  String selectedGender = 'Male';

  List<dynamic> jsonData = [];
  //get the data from the JSON file in assets folder
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    // print(data);////////////
    // setState(() {
    //   jsonData = data["items"];
    // });
  }

  @override
  void initState() {
    super.initState();
    setControllers();
    readJson();
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

  Widget buildInputRow(String label, TextEditingController controller,
      String hintText, double labelbackgroundwidth) {
    return Flexible(
      child: Stack(
        alignment: Alignment.topLeft,
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            height: 47.5,
            padding: const EdgeInsets.only(
                left: 16,
                right: 10,
                bottom: 0,
                top: 13.75), // Padding for the TextField
            decoration: BoxDecoration(
              color: const Color(0xFF1D1D22),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0x80FFFFFF), width: 2),
            ),
            child: TextField(
              cursorColor: Colors.white,
              cursorOpacityAnimates: true,
              controller: controller,
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 14,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.all(0),
                isDense: true,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          Positioned(
            top: -0.5,
            left: 7.5,
            child: Container(
              height: 10,
              width: labelbackgroundwidth,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: const Color(0xFF1D1D22),
              // color: Colors.red,
            ),
          ),
          Positioned(
            top: -8.5,
            left: 17.5,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0x80FFFFFF),
                fontWeight: FontWeight.w600,
                fontSize: 15,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputRowPhoneNo(String label, TextEditingController controller,
      String hintText, double labelbackgroundwidth) {
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
              color: const Color(0xFF1D1D22),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0x80FFFFFF), width: 2),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/flag.png',
                ),
                const SizedBox(width: 10),
                const Text(
                  '+94',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 2,
                  height: 15,
                  color: const Color(0x40FFFFFF),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: TextField(
                    cursorColor: Colors.white,
                    cursorOpacityAnimates: true,
                    controller: controller,
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.all(0),
                      isDense: true,
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -0.5,
            left: 7.5,
            child: Container(
              height: 10,
              width: labelbackgroundwidth,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: const Color(0xFF1D1D22),
            ),
          ),
          Positioned(
            top: -8.5,
            left: 17.5,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0x80FFFFFF),
                fontWeight: FontWeight.w600,
                fontSize: 15,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.left,
            ),
          ),
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
      String hintText, double labelbackgroundwidth) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          selectDate(context);
        },
        child: Stack(
          alignment: Alignment.topLeft,
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              height: 47.5,
              padding: const EdgeInsets.only(
                  left: 16,
                  right: 10,
                  bottom: 0,
                  top: 13.75), // Padding for the TextField
              decoration: BoxDecoration(
                color: const Color(0xFF1D1D22),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: const Color(0x80FFFFFF), width: 2),
              ),
              child: TextField(
                cursorColor: Colors.white,
                cursorOpacityAnimates: true,
                controller: controller,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.all(0),
                  isDense: true,
                  enabled: false,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            Positioned(
              top: -0.5,
              left: 7.5,
              child: Container(
                height: 10,
                width: labelbackgroundwidth,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: const Color(0xFF1D1D22),
              ),
            ),
            Positioned(
              top: -8.5,
              left: 17.5,
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0x80FFFFFF),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const Positioned(
              right: 15,
              top: 15,
              child: Icon(Icons.calendar_today_outlined,
                  color: Color(0xFFFFFFFF), size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGenderInput(String label, TextEditingController controller,
      String hintText, double labelbackgroundwidth) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          // openDropDown(context);
        },
        child: Stack(
          alignment: Alignment.topLeft,
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              height: 47.5,
              padding: const EdgeInsets.only(
                  left: 16,
                  right: 10,
                  bottom: 0,
                  top: 13.75), // Padding for the TextField
              decoration: BoxDecoration(
                color: const Color(0xFF1D1D22),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: const Color(0x80FFFFFF), width: 2),
              ),
              child: TextField(
                cursorColor: Colors.white,
                cursorOpacityAnimates: true,
                controller: controller,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.all(0),
                  isDense: true,
                  enabled: false,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            Positioned(
              top: -0.5,
              left: 7.5,
              child: Container(
                height: 10,
                width: labelbackgroundwidth,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: const Color(0xFF1D1D22),
              ),
            ),
            Positioned(
              top: -8.5,
              left: 17.5,
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0x80FFFFFF),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const Positioned(
              right: 15,
              top: 15,
              child: Icon(Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFFFFFFFF), size: 20),
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
                  'assets/icons/logo-small.png',
                  // width: 50,
                  height: 38,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 31, right: 31),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.125),
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: height * 0.1),
                      buildInputRow('First Name', textEditingControllers[0],
                          'Enter your first name', 95),
                      SizedBox(height: height * 0.06),
                      buildInputRow('Last Name', textEditingControllers[1],
                          'Enter your last name', 93),
                      SizedBox(height: height * 0.06),
                      buildInputRow('Email', textEditingControllers[2],
                          'Enter your email', 60),
                      SizedBox(height: height * 0.06),
                      buildInputRowPhoneNo('Phone Number',
                          textEditingControllers[3], '07XXXXXXXX', 120),
                      SizedBox(height: height * 0.06),
                      Row(
                        children: [
                          buildDoBInput('Date of Birth',
                              textEditingControllers[4], '01/01/2023', 105),
                          const SizedBox(width: 20),
                          buildGenderInput(
                              'Gender', textEditingControllers[5], 'Male', 70),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
