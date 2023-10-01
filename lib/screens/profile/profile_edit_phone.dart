import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:insurify/providers/theme_provider.dart';
import 'package:insurify/providers/user_provider.dart';
import 'package:insurify/screens/components/profile_input_field.dart';
import 'package:insurify/screens/components/top_bar.dart';
import 'package:insurify/screens/profile/profile_main_screen.dart';

class ProfileEditPhoneScreen extends StatefulWidget {
  const ProfileEditPhoneScreen({Key? key}) : super(key: key);

  @override
  ProfileEditPhoneScreenState createState() => ProfileEditPhoneScreenState();
}

class ProfileEditPhoneScreenState extends State<ProfileEditPhoneScreen>
    with SingleTickerProviderStateMixin {
  late ThemeProvider themeProvider;
  late UserDataProvider userDataProvider;
  bool isOpenphoneNo = false;
  late bool isPhoneNoValid;
  late IconData phoneNoValidationIcon;
  late Color phoneNoValidationColor;

  String otp = '';
  TextEditingController otpController = TextEditingController();
  final int digitCount = 4;

  TextEditingController phoneNoTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setControllers();
    isPhoneNoValid = false;
    phoneNoValidationIcon = Icons.close;
    phoneNoValidationColor = Colors.grey;
  }

  @override
  void dispose() {
    phoneNoTextEditingController.dispose();
    super.dispose();
  }

  void setControllers() {
    phoneNoTextEditingController.text = '';
  }

  void updateUserData() {
    userDataProvider.userData.phoneNo = phoneNoTextEditingController.text;
  }

  void updateOtpValue() {
    otp = otpController.text;
    if (otp.length == digitCount) {
      submitOtp(context, otp);
    } else {}
  }

  void submitOtp(BuildContext context, String otp) {
    if (otp == '1111' && isPhoneNoValid) {
      userDataProvider.userData
          .setPhoneNo(phoneNo: phoneNoTextEditingController.text);
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ProfileMainScreen(),
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
              child: Container(
                color: Colors.transparent,
                child: child,
              ),
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

  Widget buildBuildTextField(
    TextEditingController controller,
    String hintText,
    String label,
  ) {
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
          case 'Phone Number':
            setState(() {
              if (value.isEmpty) {
                isPhoneNoValid = false;
                phoneNoValidationIcon = Icons.close_rounded;
                phoneNoValidationColor = Colors.grey;
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
        hintStyle: TextStyle(
          color: themeProvider.themeColors["white"]!.withOpacity(0.75),
          fontWeight: FontWeight.w400,
          fontSize: 12.5,
          fontFamily: 'Inter',
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
        statusBarColor: themeProvider.themeColors["secondary"],
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              TopBar(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 95),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 41.5,
                        backgroundColor:
                            themeProvider.themeColors["secondary"]!,
                        child: userDataProvider.userData.profilePic == null
                            ? Icon(Icons.person_rounded,
                                color: themeProvider.themeColors["white"]!
                                    .withOpacity(0.75),
                                size: 45.0)
                            : CircleAvatar(
                                radius: 40.0,
                                backgroundImage:
                                    userDataProvider.userData.profilePic!.image,
                              ),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      Text(
                        '${userDataProvider.userData.fname!} ${userDataProvider.userData.lname!}',
                        style: TextStyle(
                          color: themeProvider.themeColors["white"],
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      //build first name edit row
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: buildEditRow(
                            "Phone Number",
                            "Updated Phone Number",
                            phoneNoValidationIcon,
                            phoneNoValidationColor,
                            userDataProvider.userData.phoneNo!,
                            isOpenphoneNo,
                            () {},
                            buildBuildTextField(phoneNoTextEditingController,
                                "07XXXXXXXX", "Phone Number"),
                            context),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        width: 245,
                        // margin: const EdgeInsets.symmetric(horizontal: 30),
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
                            // fixedSize: MaterialStateProperty.all<Size>(
                            //     Size(width * 0.9, 45)),
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
                        "RESEND OTP",
                        style: TextStyle(
                          color: themeProvider.themeColors["white"],
                          fontWeight: FontWeight.w600,
                          fontSize: 12.5,
                          fontFamily: 'Inter',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 30,
                right: 30,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const ProfileMainScreen(),
                          transitionsBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                          ) {
                            const begin = Offset(-1.0, 0.0);
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
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: themeProvider.themeColors["secondary"],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          themeProvider.themeIconPaths["backArrow"]!,
                          width: 15,
                          height: 15,
                        ),
                      ),
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
