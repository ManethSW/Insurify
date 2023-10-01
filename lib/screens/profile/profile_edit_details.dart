import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurify/providers/user_provider.dart';
import 'package:insurify/screens/components/top_bar.dart';
import 'package:insurify/screens/profile/profile_main_screen.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:insurify/providers/theme_provider.dart';

class ProfileEditDetailsScreen extends StatefulWidget {
  const ProfileEditDetailsScreen({Key? key}) : super(key: key);

  @override
  ProfileEditDetailsScreenState createState() =>
      ProfileEditDetailsScreenState();
}

class ProfileEditDetailsScreenState extends State<ProfileEditDetailsScreen>
    with SingleTickerProviderStateMixin {
  late ThemeProvider themeProvider;
  late UserDataProvider userDataProvider;
  bool isOpenFirstName = false;
  bool isOpenLastName = false;
  bool isOpenEmail = false;

  Image? profilePicture;
  File? profilePictureNew;
  final ValueNotifier<bool> updatePicture = ValueNotifier(false);

  late bool isFirstNameValid;
  late IconData firstNameValidationIcon;
  late Color firstNameValidationColor;
  late bool isLastNameValid;
  late IconData lastNameValidationIcon;
  late Color lastNameValidationColor;
  late bool isEmailValid;
  late IconData emailValidationIcon;
  late Color emailValidationColor;

  final List<TextEditingController> textEditingControllers = List.generate(
    3,
    (_) => TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    if (userDataProvider.userData.profilePic != null) {
      profilePicture = userDataProvider.userData.profilePic;
    }
    isFirstNameValid = false;
    firstNameValidationIcon = Icons.close;
    firstNameValidationColor = Colors.grey;
    isLastNameValid = false;
    lastNameValidationIcon = Icons.close;
    lastNameValidationColor = Colors.grey;
    isEmailValid = false;
    emailValidationIcon = Icons.close;
    emailValidationColor = Colors.grey;
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
  }

  void updateUserData() {
    userDataProvider.userData.fname = textEditingControllers[0].text;
    userDataProvider.userData.lname = textEditingControllers[1].text;
    userDataProvider.userData.email = textEditingControllers[2].text;
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    // Show a dialog to the user to pick the image source
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.65),
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: themeProvider.themeColors["primary"],
        clipBehavior: Clip.hardEdge,
        elevation: 0,
        actionsPadding: EdgeInsets.only(top: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              20), // Change this value to change the border radius
        ),
        title: Column(
          children: [
            Text(
              'Pick image from',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: themeProvider.themeColors["white"],
                fontWeight: FontWeight.w600,
                fontSize: 20,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 50,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeProvider.themeColors["white"]!.withOpacity(0.75),
              ),
            )
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, ImageSource.camera),
                child: Container(
                  width: 115,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: themeProvider.themeColors["buttonOne"],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        color: themeProvider.themeColors["white"],
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Camera',
                        style: TextStyle(
                          color: themeProvider.themeColors["white"],
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, ImageSource.gallery),
                child: Container(
                  width: 115,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: themeProvider.themeColors["buttonOne"],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.file_open_rounded,
                        color: themeProvider.themeColors["white"],
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Gallery',
                        style: TextStyle(
                          color: themeProvider.themeColors["white"],
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // If the dialog is dismissed without selecting an option, source will be null
    if (source == null) return;

    final XFile? pickedImage = await picker.pickImage(source: source);

    // If the user cancels the image picker, pickedImage will be null
    if (pickedImage == null) return;

    profilePictureNew = File(pickedImage.path);
    profilePicture = Image.file(profilePictureNew!);

    updatePicture.value = !updatePicture.value;
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
          case 'Updated First Name':
            setState(() {
              if (value.isEmpty) {
                isFirstNameValid = false;
                firstNameValidationIcon = Icons.close_rounded;
                firstNameValidationColor = Colors.grey;
              } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                isFirstNameValid = false;
                firstNameValidationIcon = Icons.close_rounded;
                firstNameValidationColor = Colors.red;
              } else {
                isFirstNameValid = true;
                firstNameValidationIcon = Icons.check;
                firstNameValidationColor = Colors.green;
              }
            });
            break;
          case 'Updated Last Name':
            setState(() {
              if (value.isEmpty) {
                isLastNameValid = false;
                lastNameValidationIcon = Icons.close_rounded;
                lastNameValidationColor = Colors.red;
              } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                isLastNameValid = false;
                lastNameValidationIcon = Icons.close_rounded;
                lastNameValidationColor = Colors.red;
              } else {
                isLastNameValid = true;
                lastNameValidationIcon = Icons.check;
                lastNameValidationColor = Colors.green;
              }
            });
            break;
          case 'Updated Email':
            setState(() {
              if (value.isEmpty) {
                isEmailValid = false;
                emailValidationIcon = Icons.close_rounded;
                emailValidationColor = Colors.red;
              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                isEmailValid = false;
                emailValidationIcon = Icons.close_rounded;
                emailValidationColor = Colors.red;
              } else {
                isEmailValid = true;
                emailValidationIcon = Icons.check;
                emailValidationColor = Colors.green;
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      height: isOpen ? 130 : 57.5,
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
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: onToggleOpen,
              child: Container(
                width: 45,
                height: 47.5,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeProvider.themeColors["primary"],
                ),
                child: Center(
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    turns: isOpen ? 0.25 : 0.75,
                    child: SvgPicture.asset(
                      themeProvider.themeIconPaths["backArrow"]!,
                      width: 10,
                      height: 10,
                    ),
                  ),
                ),
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
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            child: GestureDetector(
                              onTap: () {
                                _pickImage();
                              },
                              child: CircleAvatar(
                                radius: 41.5,
                                backgroundColor:
                                    themeProvider.themeColors["buttonOne"]!,
                                child: ValueListenableBuilder<bool>(
                                  valueListenable: updatePicture,
                                  builder: (context, value, child) {
                                    return profilePicture == null
                                        ? Icon(Icons.person_rounded,
                                            color: themeProvider
                                                .themeColors["white"]!
                                                .withOpacity(0.75),
                                            size: 45.0)
                                        : CircleAvatar(
                                            radius: 40.0,
                                            backgroundImage:
                                                profilePicture!.image,
                                          );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: -2.5,
                            child: GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 13.5,
                                backgroundColor:
                                    themeProvider.themeColors["white"]!,
                                child: CircleAvatar(
                                  radius: 12.5,
                                  backgroundColor:
                                      themeProvider.themeColors["buttonOne"]!,
                                  child: Icon(
                                    Icons.edit,
                                    color: themeProvider.themeColors["white"]!,
                                    size: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.020,
                      ),
                      Text(
                        'Edit Profile Picture',
                        style: TextStyle(
                          color: themeProvider.themeColors["white"],
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      //build first name edit row
                      buildEditRow(
                        "First Name",
                        "Updated First Name",
                        textEditingControllers[0],
                        "Enter your new first name",
                        132.5,
                        firstNameValidationIcon,
                        firstNameValidationColor,
                        userDataProvider.userData.fname!,
                        isOpenFirstName,
                        () {
                          setState(() {
                            isOpenFirstName =
                                !isOpenFirstName; // Toggle the first _isOpen state
                          });
                        },
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      buildEditRow(
                        "Last Name",
                        "Updated Last Name",
                        textEditingControllers[1],
                        "Enter your new last name",
                        130,
                        lastNameValidationIcon,
                        lastNameValidationColor,
                        userDataProvider.userData.lname!,
                        isOpenLastName,
                        () {
                          setState(() {
                            isOpenLastName =
                                !isOpenLastName; // Toggle the first _isOpen state
                          });
                        },
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      buildEditRow(
                        "Email",
                        "Updated Email",
                        textEditingControllers[2],
                        "Enter your new email",
                        100,
                        emailValidationIcon,
                        emailValidationColor,
                        userDataProvider.userData.email!,
                        isOpenEmail,
                        () {
                          setState(() {
                            isOpenEmail =
                                !isOpenEmail; // Toggle the first _isOpen state
                          });
                        },
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
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 300),
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
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        // flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            if (isFirstNameValid) {
                              userDataProvider.userData.setFirstName(
                                  fname: textEditingControllers[0].text);
                            }
                            if (isLastNameValid) {
                              userDataProvider.userData.setlastName(
                                  lname: textEditingControllers[1].text);
                            }
                            if (isEmailValid) {
                              userDataProvider.userData.setEmail(
                                  email: textEditingControllers[2].text);
                            }
                            if (profilePicture != null) {
                              userDataProvider.userData
                                  .setProfilePic(profilePic: profilePicture);
                            }
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 300),
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: themeProvider.themeColors["buttonOne"],
                            ),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: themeProvider.themeColors["white"],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
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
            ],
          ),
        ),
      ),
    );
  }
}
