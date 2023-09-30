import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insurify/providers/theme_provider.dart';
import 'package:insurify/screens/components/startup_screen_heading.dart';
import 'package:insurify/screens/register/register_three_screen.dart';
import 'package:pinput/pinput.dart';

import 'package:insurify/screens/components/build_bottom_buttons.dart';
import 'package:insurify/screens/register/register_one_screen.dart';
import 'package:provider/provider.dart';

class RegisterTwoScreen extends StatefulWidget {
  const RegisterTwoScreen({Key? key}) : super(key: key);

  @override
  RegisterTwoScreenState createState() => RegisterTwoScreenState();
}

class RegisterTwoScreenState extends State<RegisterTwoScreen> {
  late ThemeProvider themeProvider;
  String otp = '';
  TextEditingController otpController = TextEditingController();
  final int digitCount = 4;

  void updateOtpValue() {
    otp = otpController.text;
    if (otp.length == digitCount) {
      submitOtp(context, otp);
    } else {}
  }

  List<dynamic> jsonData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void submitOtp(BuildContext context, String otp) {
    print('working');
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeProvider.themeColors["primary"],
        systemNavigationBarColor:
            themeProvider.themeColors["primary"],
      ),
    );
    final defaultPinTheme = PinTheme(
      width: 55,
      height: 55,
      margin: const EdgeInsets.only(top: 30),
      textStyle: TextStyle(
          fontSize: 20,
          color: themeProvider.themeColors["white"],
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: themeProvider.themeColors["buttonOne"],
        borderRadius: BorderRadius.circular(10),
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
                      buildStartUpScreenHeading(context, 'Sign Up'),
                      SizedBox(height: height * 0.075),
                      Text(
                        "Verify your phone number",
                        style: TextStyle(
                          color: themeProvider.themeColors["white"],
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
                      Text(
                        "Didn't receive an OTP?",
                        style: TextStyle(
                          color: themeProvider.themeColors["white"],
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      Text(
                        "RESEND OTP",
                        style: TextStyle(
                          color: themeProvider.themeColors["white"],
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
                  const RegisterOneScreen(),
                  const RegisterThreeScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
