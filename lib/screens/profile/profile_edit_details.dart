import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:insurify/providers/theme_provider.dart';
import 'package:insurify/providers/user_provider.dart';
import 'package:insurify/screens/components/profile_input_field.dart';
import 'package:insurify/screens/components/top_bar.dart';

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
                    color: themeProvider.themeColors["secondary"],
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
                    color: themeProvider.themeColors["secondary"],
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
          case 'First Name':
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
          case 'Last Name':
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
          case 'Email':
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
                                    themeProvider.themeColors["secondary"]!,
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
                                      themeProvider.themeColors["secondary"]!,
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: buildEditRow(
                            "First Name",
                            "Updated First Name",
                            firstNameValidationIcon,
                            firstNameValidationColor,
                            userDataProvider.userData.fname!,
                            isOpenFirstName, () {
                          setState(() {
                            isOpenFirstName = !isOpenFirstName;
                          });
                        },
                            buildBuildTextField(
                                textEditingControllers[0],
                                "Enter your new first name",
                                "First Name"),
                            context),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: buildEditRow(
                            "Last Name",
                            "Updated Last Name",
                            lastNameValidationIcon,
                            lastNameValidationColor,
                            userDataProvider.userData.lname!,
                            isOpenLastName, () {
                          setState(() {
                            isOpenLastName = !isOpenLastName;
                          });
                        },
                            buildBuildTextField(
                                textEditingControllers[1],
                                "Enter your new last name",
                                "Last Name"),
                            context),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: buildEditRow(
                            "Email",
                            "Updated Email",
                            emailValidationIcon,
                            emailValidationColor,
                            userDataProvider.userData.email!,
                            isOpenEmail, () {
                          setState(() {
                            isOpenEmail = !isOpenEmail;
                          });
                        },
                            buildBuildTextField(textEditingControllers[2],
                                "Enter your new email", "Email"),
                            context),
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
                          Navigator.pop(context);
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
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: themeProvider.themeColors["secondary"],
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
