import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurify/providers/user_provider.dart';
import 'package:insurify/screens/components/top_bar.dart';
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
  bool _isOpen = false;

  Image? profilePicture;
  File? profilePictureNew;
  final ValueNotifier<bool> updatePicture = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    if (userDataProvider.userData.profilePic != null) {
      profilePicture = userDataProvider.userData.profilePic;
    }
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
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                        height: _isOpen ? 130 : 55,
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
                              margin: const EdgeInsets.only(top: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "First Name",
                                    style: TextStyle(
                                      color: themeProvider.themeColors["white"]!
                                          .withOpacity(0.50),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.5,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    userDataProvider.userData.fname!,
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
                            Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isOpen = !_isOpen;
                                  });
                                },
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
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.easeInOut,
                                      turns: _isOpen ? 0.25 : 0.75,
                                      child: SvgPicture.asset(
                                        themeProvider
                                            .themeIconPaths["backArrow"]!,
                                        width: 10,
                                        height: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            _isOpen
                                ? Container(
                                    margin: EdgeInsets.only(top: 70, right: 12, bottom: 12),
                                    height: 50,
                                    // width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: themeProvider
                                          .themeColors["primary"],
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      )
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
                        onTap: () {},
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
                          onTap: () {},
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
