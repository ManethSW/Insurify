import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurify/providers/theme_provider.dart';
import 'package:insurify/providers/user_provider.dart';
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
  late ThemeProvider themeProvider;
  late bool isFirstNameValid;
  late String firstNameValidationText;
  late Color firstNameValidationColor;
  late bool isLastNameValid;
  late String lastNameValidationText;
  late Color lastNameValidationColor;
  late bool isEmailValid;
  late String emailValidationText;
  late Color emailValidationColor;
  late bool isPhoneNoValid;
  late String phoneNoValidationText;
  late Color phoneNoValidationColor;
  late bool isDobValid;
  late String dobValidationText;
  late Color dobValidationColor;

  UserData userData = UserData(
      fname: '',
      lname: '',
      email: '',
      phoneNo: '',
      dob: DateTime.now());
  final List<TextEditingController> textEditingControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    setControllers();
    isFirstNameValid = false;
    firstNameValidationText = 'Please enter your first name';
    firstNameValidationColor = Colors.grey;
    isLastNameValid = false;
    lastNameValidationText = 'Please enter your last name';
    lastNameValidationColor = Colors.grey;
    isEmailValid = false;
    emailValidationText = 'Please enter valid email';
    emailValidationColor = Colors.grey;
    isPhoneNoValid = false;
    phoneNoValidationText = 'Please enter valid phone number';
    phoneNoValidationColor = Colors.grey;
    isDobValid = false;
    dobValidationText = 'Select your date of birth';
    dobValidationColor = Colors.grey;
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
    // textEditingControllers[5].text = 'Male';
  }

  void updateUserData() {
    userData.fname = textEditingControllers[0].text;
    userData.lname = textEditingControllers[1].text;
    userData.email = textEditingControllers[2].text;
    userData.phoneNo = textEditingControllers[3].text;
    userData.dob = DateTime.parse(textEditingControllers[4].text);
    // userData.gender = textEditingControllers[5].text;
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
        switch (label) {
          case 'First Name':
            setState(() {
              if (value.isEmpty) {
                isFirstNameValid = false;
                firstNameValidationText = 'Please enter your first name';
                firstNameValidationColor = Colors.red;
              } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                isFirstNameValid = false;
                firstNameValidationText = 'Invalid name';
                firstNameValidationColor = Colors.red;
              } else {
                isFirstNameValid = true;
                firstNameValidationText = 'Valid name';
                firstNameValidationColor = Colors.green;
              }
            });
            break;
          case 'Last Name':
            setState(() {
              if (value.isEmpty) {
                isLastNameValid = false;
                lastNameValidationText = 'Please enter your last name';
                lastNameValidationColor = Colors.red;
              } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                isLastNameValid = false;
                lastNameValidationText = 'Invalid name';
                lastNameValidationColor = Colors.red;
              } else {
                isLastNameValid = true;
                lastNameValidationText = 'Valid name';
                lastNameValidationColor = Colors.green;
              }
            });
            break;
          case 'Email':
            setState(() {
              if (value.isEmpty) {
                isEmailValid = false;
                emailValidationText = 'Please enter your email address';
                emailValidationColor = Colors.red;
              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                isEmailValid = false;
                emailValidationText = 'Invalid email address';
                emailValidationColor = Colors.red;
              } else {
                isEmailValid = true;
                emailValidationText = 'Valid email address';
                emailValidationColor = Colors.green;
              }
            });
            break;
          case 'Phone Number':
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
            break;
          case 'Date of Birth':
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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(textEditingControllers[4].text),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.parse(textEditingControllers[4].text),
    );
    if (picked != null) {
      if (picked.isAfter(DateTime.now().subtract(Duration(days: 365 * 18)))) {
        // selected date is less than 18 years ago
        setState(() {
          isDobValid = false;
          dobValidationText = 'You must be 18+';
          dobValidationColor = Colors.red;
          textEditingControllers[4].text = "${picked.toLocal()}".split(' ')[0];
        });
      } else {
        setState(() {
          isDobValid = true;
          dobValidationText = 'Valid Date of birth';
          dobValidationColor = Colors.green;
          textEditingControllers[4].text = "${picked.toLocal()}".split(' ')[0];
        });
      }
    }
  }

  Widget buildDoBInput(
      String label,
      TextEditingController controller,
      String hintText,
      double labelbackgroundwidth,
      bool textFieldTyping,
      bool isValid,
      String validationText,
      Color validationColor) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          selectDate(context);
        },
        child: Stack(
          alignment: Alignment.topLeft,
          clipBehavior: Clip.none,
          children: <Widget>[
            buildBuildTextFieldContainer(controller, hintText, textFieldTyping,
                label, isValid, validationText, validationColor),
            buildTextFieldLabelBackground(labelbackgroundwidth),
            buildTextFieldLabel(label),
            Positioned(
              right: 15,
              top: 15,
              child: Icon(
                Icons.calendar_today_outlined,
                color: themeProvider.themeColors["white"],
                size: 20,
              ),
            ),
            Positioned(
              bottom: -20,
              right: 0,
              child: Text(
                validationText,
                style: TextStyle(
                  color: validationColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  fontFamily: 'Inter',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeProvider.themeColors["primary"],
        systemNavigationBarColor: themeProvider.themeColors["primary"],
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
                      SizedBox(height: height * 0.1),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: themeProvider.themeColors["white"],
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: height * 0.075),
                      buildInputRow(
                          'First Name',
                          textEditingControllers[0],
                          'John',
                          95,
                          true,
                          isFirstNameValid,
                          firstNameValidationText,
                          firstNameValidationColor),
                      SizedBox(height: height * 0.065),
                      buildInputRow(
                          'Last Name',
                          textEditingControllers[1],
                          'Doe',
                          93,
                          true,
                          isLastNameValid,
                          lastNameValidationText,
                          lastNameValidationColor),
                      SizedBox(height: height * 0.065),
                      buildInputRow(
                          'Email',
                          textEditingControllers[2],
                          'johndoe@gmail.com',
                          60,
                          true,
                          isEmailValid,
                          emailValidationText,
                          emailValidationColor),
                      SizedBox(height: height * 0.065),
                      buildInputRowPhoneNo(
                          'Phone Number',
                          textEditingControllers[3],
                          '07XXXXXXXX',
                          120,
                          true,
                          isPhoneNoValid,
                          phoneNoValidationText,
                          phoneNoValidationColor),
                      SizedBox(height: height * 0.065),
                      buildDoBInput(
                          'Date of Birth',
                          textEditingControllers[4],
                          '01/01/2023',
                          105,
                          false,
                          isDobValid,
                          dobValidationText,
                          dobValidationColor),
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
                  RegisterTwoScreen(userData: userData),
                  () {
                    //check to see if all validation variables are true
                    if (isFirstNameValid &&
                        isLastNameValid &&
                        isEmailValid &&
                        isPhoneNoValid &&
                        isDobValid) {
                      updateUserData();
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  RegisterTwoScreen(userData: userData),
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
                            'Please fill in all the required fields.',
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
