import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:insurify/screens/components/startup_screen_heading.dart';
import 'package:insurify/screens/login/login_one_screen.dart';
import 'package:insurify/screens/register/register_three_scren.dart';
import 'package:pinput/pinput.dart';

import 'package:flutter/services.dart';
import 'package:insurify/screens/components/build_bottom_buttons.dart';
import 'package:insurify/screens/register/register_one_screen.dart';

class LoginTwoScreen extends StatefulWidget {
  const LoginTwoScreen({Key? key}) : super(key: key);

  @override
  LoginTwoScreenState createState() => LoginTwoScreenState();
}

class LoginTwoScreenState extends State<LoginTwoScreen> {
  String otp = '';
  TextEditingController otpController = TextEditingController();
  final int digitCount = 4;

  void updateOtpValue() {
    otp = otpController.text;
    if (otp.length == digitCount) {
      submitOtp(context, otp);
    } else {}
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void submitOtp(BuildContext context, String otp) {
    print('working');
  }

  final defaultPinTheme = PinTheme(
    width: 55,
    height: 55,
    margin: const EdgeInsets.only(top: 30),
    textStyle: const TextStyle(
        fontSize: 20, color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: const Color(0xFF1D1D22),
      borderRadius: BorderRadius.circular(10),
    ),
  );

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
                      buildStartUpScreenHeading('Login In'),
                      SizedBox(height: height * 0.075),
                      const Text(
                        "Verify your phone number",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                      Pinput(
                        length: digitCount,
                        defaultPinTheme: defaultPinTheme,
                        controller: otpController,
                        onChanged: (value) {
                          updateOtpValue();
                        },
                      ),
                      SizedBox(height: height * 0.05),
                      const Text(
                        "Didn't receive an OTP?",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      const Text(
                        "RESEND OTP",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          decoration: TextDecoration.underline,
                        ),
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
                  const LoginOneScreen(),
                  const Placeholder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
