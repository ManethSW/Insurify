import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurify/providers/user_provider.dart';
import 'package:insurify/screens/components/top_bar.dart';
import 'package:insurify/screens/profile/profile_main_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:insurify/providers/theme_provider.dart';

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
      //Update the userDataProvider with the userData
      userDataProvider.userData.setPhoneNo(phoneNo: phoneNoTextEditingController.text);
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
            backgroundColor: themeProvider.themeColors["buttonOne"],
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
          case 'Updated Phone Number':
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

  Widget buildBuildTextFieldContainer(
      TextEditingController controller,
      String hintText,
      bool textFieldTyping,
      String label,
      bool isValid,
      IconData validationIcon,
      Color validationColor) {
    return Container(
      height: 42.5,
      padding: const EdgeInsets.only(
          left: 16,
          right: 10,
          bottom: 0,
          top: 11.5), // Padding for the TextField
      decoration: BoxDecoration(
        color: themeProvider.themeColors["textFieldBackground"],
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: themeProvider.themeColors["textFieldBorderAndLabel"]!,
            width: 2),
      ),
      child: buildBuildTextField(controller, hintText, label),
    );
  }

  Widget buildTextFieldLabel(String label) {
    return Positioned(
      top: -10,
      left: 17.5,
      child: Text(
        label,
        style: TextStyle(
          color: themeProvider.themeColors["textFieldBorderAndLabel"],
          fontWeight: FontWeight.w600,
          fontSize: 12.5,
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
        color: themeProvider.themeColors["textFieldBackground"],
        // color: Colors.red,
      ),
    );
  }

  Widget buildInputRow(
      String label,
      TextEditingController controller,
      String hintText,
      double labelbackgroundwidth,
      IconData validationIcon,
      Color validationColor) {
    return Stack(
      alignment: Alignment.topLeft,
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          height: 47.5,
          padding: const EdgeInsets.only(
              left: 16, right: 10, bottom: 0), // Padding for the TextField
          decoration: BoxDecoration(
            color: themeProvider.themeColors["textFieldBackground"],
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: themeProvider.themeColors["textFieldBorderAndLabel"]!,
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
                  color: themeProvider.themeColors["white"],
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 2,
                height: 15,
                color: themeProvider.themeColors["phontNumberSeperator"],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: buildBuildTextField(
                  controller,
                  hintText,
                  label,
                ),
              ),
              Icon(
                validationIcon,
                size: 20,
                color: validationColor,
              )
            ],
          ),
        ),
        buildTextFieldLabelBackground(labelbackgroundwidth),
        buildTextFieldLabel(label),
      ],
    );
  }

  Widget buildEditRow(
      String label,
      String editLabel,
      TextEditingController controller,
      String hintText,
      double labelbackgroundwidth,
      IconData validationIcon,
      Color validationColor,
      String currentValue,
      bool isOpen,
      VoidCallback onToggleOpen) {
    return Container(
      height: 130,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: themeProvider.themeColors["buttonOne"],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: 55,
            margin: const EdgeInsets.only(top: 11.25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color:
                        themeProvider.themeColors["white"]!.withOpacity(0.50),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  currentValue,
                  style: TextStyle(
                    color: themeProvider.themeColors["white"],
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                    fontFamily: 'Inter',
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              height: 47.5,
              margin: EdgeInsets.only(top: 70, right: 12, bottom: 12),
              child: buildInputRow(
                editLabel,
                controller,
                hintText,
                labelbackgroundwidth,
                validationIcon,
                validationColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    userDataProvider = Provider.of<UserDataProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeProvider.themeColors["buttonOne"],
        systemNavigationBarColor: themeProvider.themeColors["primary"],
        // statusBarColor: Colors.yellow,
        // systemNavigationBarColor: Colors.yellow,
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
              buildTopBar(context),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 95),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 41.5,
                        backgroundColor:
                            themeProvider.themeColors["buttonOne"]!,
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
                      buildEditRow(
                        "Phone Number",
                        "Updated Phone Number",
                        phoneNoTextEditingController,
                        "077XXXXXXX",
                        155,
                        phoneNoValidationIcon,
                        phoneNoValidationColor,
                        userDataProvider.userData.phoneNo!,
                        isOpenphoneNo,
                        () {
                          setState(() {
                            isOpenphoneNo =
                                !isOpenphoneNo; // Toggle the first _isOpen state
                          });
                        },
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        width: 245,
                        // margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            // fixedSize: MaterialStateProperty.all<Size>(
                            //     Size(width * 0.9, 45)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              themeProvider.themeColors["buttonOne"]!,
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
                        color: themeProvider.themeColors["buttonOne"],
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
