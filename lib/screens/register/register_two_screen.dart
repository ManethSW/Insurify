import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insurify/providers/global_provider.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pinput.dart';

import 'package:insurify/providers/theme_provider.dart';
import 'package:insurify/providers/user_provider.dart';
import 'package:insurify/screens/components/startup_screen_heading.dart';
import 'package:insurify/screens/components/bottom_buttons.dart';
import 'package:insurify/screens/register/register_three_screen.dart';

class RegisterTwoScreen extends StatefulWidget {
  final UserData userData;

  const RegisterTwoScreen({required this.userData, Key? key}) : super(key: key);

  @override
  RegisterTwoScreenState createState() => RegisterTwoScreenState();
}

class RegisterTwoScreenState extends State<RegisterTwoScreen> {
  late UserDataProvider userDataProvider;
  late ThemeProvider themeProvider;
  late GlobalProvider globalProvider;
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
    if (otp == '1111') {
      userDataProvider.userData.setData(
        fname: widget.userData.fname,
        lname: widget.userData.lname,
        email: widget.userData.email,
        phoneNo: widget.userData.phoneNo,
        dob: widget.userData.dob,
      );
      userDataProvider.userData.setProfilePic(
        profilePic: widget.userData.profilePic,
      );
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const RegisterThreeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
            'Wrong OTP, please try again',
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
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    userDataProvider = Provider.of<UserDataProvider>(context);
    globalProvider = Provider.of<GlobalProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeProvider.themeColors["primary"],
        systemNavigationBarColor: themeProvider.themeColors["primary"],
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
        color: themeProvider.themeColors["secondary"],
        borderRadius: BorderRadius.circular(10),
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
                      SizedBox(height: height * 0.125),
                      buildStartUpScreenHeading(context, 'Sign Up'),
                      SizedBox(height: height * 0.075),
                      Text(
                        "Verify You Phone Number",
                        style: TextStyle(
                          color: themeProvider.themeColors["white"],
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      Pinput(
                        length: digitCount,
                        defaultPinTheme: defaultPinTheme,
                        controller: otpController,
                        onChanged: (value) {
                          updateOtpValue();
                        },
                      ),
                      SizedBox(height: height * 0.05),
                      SizedBox(
                        width: 245,
                        child: TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor:
                                    themeProvider.themeColors["primary"],
                                content: Text(
                                  'OTP code has been sent',
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
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              themeProvider.themeColors["secondary"]!,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: Text(
                            'Request for OTP Code',
                            style: TextStyle(
                              color: themeProvider.themeColors["white"],
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 31,
                left: 0,
                right: 0,
                child: SizedBox(
                  child: Center(
                    child: buildBackButton(
                      context,
                      width,
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
