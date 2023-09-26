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
                  'assets/icons/logo-small-dark-mode.png',
                  // width: 50,
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
                      buildStartUpScreenHeading('Sign Up'),
                      SvgPicture.asset(
                        'assets/icons/checkmark.svg',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      const SizedBox(
                        width: 175,
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF3A9D62),
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 90,
                left: width * 0.1,
                right: width * 0.1,
                child: const Text(
                  "Please login to access the application",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0x80FFFFFF),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              Positioned(
                bottom: 31,
                left: 31,
                right: 31,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const LoginTwoScreen(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          final tween = Tween(begin: begin, end: end);
                          final curvedAnimation = CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut,
                          );
                          return SlideTransition(
                            position: tween.animate(curvedAnimation),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF16161B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Next',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          'assets/icons/forward.svg',
                          width: 12,
                          height: 12,
                        ),
                      ],
                    ),
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