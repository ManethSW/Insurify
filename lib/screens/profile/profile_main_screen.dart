import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurify/providers/user_provider.dart';
import 'package:insurify/screens/components/top_bar.dart';
import 'package:insurify/screens/profile/profile_edit_details.dart';
import 'package:insurify/screens/profile/profile_edit_phone.dart';
import 'package:insurify/screens/startup/startup_screen.dart';
import 'package:provider/provider.dart';

import 'package:insurify/providers/theme_provider.dart';

class ProfileMainScreen extends StatefulWidget {
  const ProfileMainScreen({Key? key}) : super(key: key);

  @override
  ProfileMainScreenState createState() => ProfileMainScreenState();
}

class ProfileMainScreenState extends State<ProfileMainScreen>
    with SingleTickerProviderStateMixin {
  late ThemeProvider themeProvider;
  late UserDataProvider userDataProvider;
  bool _isDarkMode = false;

  Widget buildButton(String label, Widget page) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: themeProvider.themeColors["secondary"],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                label,
                style: TextStyle(
                  color: themeProvider.themeColors["white"],
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          Positioned(
            right: 5,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        page,
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
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
                ).then((value) {
                  setState(() {});
                });
              },
              child: Container(
                width: 50,
                height: 37.5,
                decoration: BoxDecoration(
                  color: themeProvider.themeColors["primary"],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                      themeProvider.themeIconPaths["backArrow"]!,
                      width: 12.5,
                      height: 12.5,
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
              const TopBar(),
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
                        height: height * 0.0025,
                      ),
                      Text(
                        userDataProvider.userData.email!,
                        style: TextStyle(
                          color: themeProvider.themeColors["white"]!
                              .withOpacity(0.75),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            themeProvider.toggleTheme();
                            _isDarkMode = !_isDarkMode;
                          });
                        },
                        child: Container(
                          width: 115,
                          height: 42.5,
                          decoration: BoxDecoration(
                            color: themeProvider.themeColors["secondary"],
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: AlignmentDirectional.center,
                            children: [
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInOut,
                                top: 5,
                                left: _isDarkMode ? 60 : 5,
                                child: Container(
                                  width: 50,
                                  height: 32.5,
                                  decoration: BoxDecoration(
                                    color: themeProvider.themeColors["primary"],
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 17.5,
                                child: SvgPicture.asset(
                                  themeProvider.themeIconPaths["darkMode"]!,
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                              Positioned(
                                right: 17.5,
                                child: SvgPicture.asset(
                                  themeProvider.themeIconPaths["lightMode"]!,
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      buildButton(
                        "Change Personal Details",
                        const ProfileEditDetailsScreen(),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      buildButton(
                        "Change Phone Number",
                        const ProfileEditPhoneScreen(),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 30,
                right: 30,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const StartupScreen(),
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
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: themeProvider.themeColors["secondary"],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      alignment: AlignmentDirectional.center,
                      children: [
                        Positioned(
                          left: 15,
                          child: Image.asset(
                            themeProvider.themeIconPaths["signout"]!,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Sign Out',
                            style: TextStyle(
                              color: themeProvider.themeColors["white"],
                              fontWeight: FontWeight.w400,
                              fontSize: 17.5,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
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
