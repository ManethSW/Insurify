import 'package:flutter/material.dart';
import 'package:insurify/providers/theme_provider.dart';
import 'package:insurify/providers/user_provider.dart';
import 'package:insurify/screens/components/build_bottom_buttons.dart';
import 'package:insurify/screens/components/startup_screen_heading.dart';
import 'package:insurify/screens/login/login_two_screen.dart';
import 'package:insurify/screens/startup/startup_screen.dart';
import 'package:provider/provider.dart';

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
  late String phoneNoValidationText;
  late Color phoneNoValidationColor;

  @override
  void initState() {
    super.initState();
    setControllers();
    isPhoneNoValid = false;
    phoneNoValidationText = 'Please enter valid phone number';
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

  Widget buildBuildTextField(
      TextEditingController controller,
      String hintText,
      bool textFieldTyping,
      String label,
      bool isValid,
      String validationText,
      Color validationColor) {
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
            phoneNoValidationText = 'Please enter your phone number';
            phoneNoValidationColor = Colors.red;
          } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
            isPhoneNoValid = false;
            phoneNoValidationText = 'Invalid phone number';
            phoneNoValidationColor = Colors.red;
          } else {
            isPhoneNoValid = true;
            phoneNoValidationText = 'Valid phone number';
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

  Widget buildBuildTextFieldContainer(
      TextEditingController controller,
      String hintText,
      bool textFieldTyping,
      String label,
      bool isValid,
      String validationText,
      Color validationColor) {
    return Container(
      height: 47.5,
      padding: const EdgeInsets.only(
          left: 16,
          right: 10,
          bottom: 0,
          top: 13.75), // Padding for the TextField
      decoration: BoxDecoration(
        color: themeProvider.themeColors["textFieldBackground"],
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: themeProvider.themeColors["textFieldBorderAndLabel"]!,
            width: 2),
      ),
      child: buildBuildTextField(controller, hintText, textFieldTyping, label,
          isValid, validationText, validationColor),
    );
  }

  Widget buildTextFieldLabel(String label) {
    return Positioned(
      top: -8.5,
      left: 17.5,
      child: Text(
        label,
        style: TextStyle(
          color: themeProvider.themeColors["textFieldBorderAndLabel"],
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
      bool textFieldTyping,
      bool isValid,
      String validationText,
      Color validationColor) {
    return Flexible(
      child: Stack(
        alignment: Alignment.topLeft,
        clipBehavior: Clip.none,
        children: <Widget>[
          buildBuildTextFieldContainer(controller, hintText, textFieldTyping,
              label, isValid, validationText, validationColor),
          buildTextFieldLabelBackground(labelbackgroundwidth),
          buildTextFieldLabel(label),
          Positioned(
            bottom: -20,
            right: 0,
            child: Text(
              validationText,
              style: TextStyle(
                // color: Colors.green,
                color: validationColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildInputRowPhoneNo(
      String label,
      TextEditingController controller,
      String hintText,
      double labelbackgroundwidth,
      bool textFieldTyping,
      bool isValid,
      String validationText,
      Color validationColor) {
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
                Flexible(
                  child: buildBuildTextField(
                    controller,
                    hintText,
                    textFieldTyping,
                    label,
                    isValid,
                    validationText,
                    validationColor,
                  ),
                ),
              ],
            ),
          ),
          buildTextFieldLabelBackground(labelbackgroundwidth),
          buildTextFieldLabel(label),
          Positioned(
            bottom: -20,
            right: 0,
            child: Text(
              validationText,
              style: TextStyle(
                // color: Colors.green,
                color: validationColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    userDataProvider = Provider.of<UserDataProvider>(context);
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
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: height * 0.125),
                      buildStartUpScreenHeading(context, 'Login'),
                      SizedBox(height: height * 0.075),
                      buildInputRowPhoneNo(
                          'Phone Number',
                          phoneNoController,
                          '07XXXXXXXX',
                          120,
                          true,
                          isPhoneNoValid,
                          phoneNoValidationText,
                          phoneNoValidationColor),
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
                  StartupScreen(),
                  const LoginTwoScreen(),
                  () {
                    if (isPhoneNoValid) {
                      if (phoneNoController.text ==
                          userDataProvider.userData.phoneNo) {
                        Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
                            'User does not exist',
                            style: TextStyle(
                              color: themeProvider.themeColors["white"],
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          ),
                          action: SnackBarAction(
                            backgroundColor:
                                themeProvider.themeColors["buttonOne"],
                            label: 'OK',
                            textColor: themeProvider.themeColors["white"],
                            onPressed: () {},
                          ),
                        ),
                      );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: themeProvider.themeColors["primary"],
                          content: Text(
                            'Please fill in a valid phone number',
                            style: TextStyle(
                              color: themeProvider.themeColors["white"],
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          ),
                          action: SnackBarAction(
                            backgroundColor:
                                themeProvider.themeColors["buttonOne"],
                            label: 'OK',
                            textColor: themeProvider.themeColors["white"],
                            onPressed: () {},
                          ),
                        ),
                      );
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
