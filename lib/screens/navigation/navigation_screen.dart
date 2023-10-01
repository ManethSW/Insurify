import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insurify/providers/user_provider.dart';
import 'package:insurify/screens/add_insurance/add_insurance_main_screen.dart';
import 'package:insurify/screens/blog/blog_main_screen.dart';
import 'package:insurify/screens/home/home_screen.dart';
import 'package:insurify/screens/profile/profile_main_screen.dart';
import 'package:insurify/screens/startup/startup_screen.dart';
import 'package:provider/provider.dart';

import 'package:insurify/providers/theme_provider.dart';
import 'package:insurify/providers/global_provider.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen> {
  late ThemeProvider themeProvider;
  late GlobalProvider globalProvider;
  late UserDataProvider userDataProvider;

  //list for the name of the screens
  final List<String> screens = [
    'profile',
    'home',
    'addInsurance',
    'blogs',
    'startup',
  ];

  Widget buildNavigationItem(
      String icon, String label, String screen, Widget page) {
    globalProvider = Provider.of<GlobalProvider>(context);

    void onTapHandler() {
      setState(() {
        globalProvider.setCurrentScreen(screen);
      });
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => page,
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
              child: Container(
                color: Colors.transparent,
                child: child,
              ),
            );
          },
        ),
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        //logic
        if (globalProvider.currentScreen == screen) {
          return GestureDetector(
            onTap: () {
              onTapHandler();
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 15, top: 10, right: 20, bottom: 10),
              decoration: BoxDecoration(
                color: themeProvider.themeColors["secondary"],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    themeProvider.themeIconPaths[icon]!,
                    height: 22.5,
                    width: 22.5,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w400,
                      color: themeProvider.themeColors["white"],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              onTapHandler();
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 15, top: 10, right: 20, bottom: 10),
              // width: ,
              // height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    themeProvider.themeIconPaths[icon]!,
                    height: 22.5,
                    width: 22.5,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w400,
                      color: themeProvider.themeColors["white"],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    userDataProvider = Provider.of<UserDataProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            themeProvider.themeColors["secondary"]!.withOpacity(0.5),
        systemNavigationBarColor:
            themeProvider.themeColors["secondary"]!.withOpacity(0.99),
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
          backgroundColor:
              themeProvider.themeColors["secondary"]!.withOpacity(0.5),
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned(
                top: 60,
                right: 20,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close_rounded),
                  color: themeProvider.themeColors["white"],
                  iconSize: 35,
                ),
              ),
              Positioned(
                top: 120,
                right: 0,
                child: Image.asset(
                  themeProvider.themeIconPaths["homePage"]!,
                  // height: 100,
                  width: width * 0.21,
                ),
              ),
              SizedBox(
                width: width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 40, top: 50, bottom: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 36.5,
                                    backgroundColor:
                                        themeProvider.themeColors["secondary"]!,
                                    child: userDataProvider
                                                .userData.profilePic ==
                                            null
                                        ? Icon(Icons.person_rounded,
                                            color: themeProvider
                                                .themeColors["white"]!
                                                .withOpacity(0.75),
                                            size: 40.0)
                                        : CircleAvatar(
                                            radius: 35.0,
                                            backgroundImage: userDataProvider
                                                .userData.profilePic!.image,
                                          ),
                                  ),
                                  SizedBox(height: height * 0.025),
                                  Text(
                                    'Good Morning',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: themeProvider.themeColors["white"]!
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.015),
                                  Text(
                                    'Maneth Weerasinghe',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: themeProvider.themeColors["white"],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            buildNavigationItem("profile", 'Profile',
                                screens[0], const ProfileMainScreen()),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            buildNavigationItem(
                                "home", 'Home', screens[1], const HomeScreen()),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            buildNavigationItem("plus", 'Add New Insurance',
                                screens[2], const AddInsuranceMainScreen()),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            buildNavigationItem("blog", 'View Blogs',
                                screens[3], const BlogMainScreen()),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 2,
                              width: 115,
                              margin: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                color: themeProvider.themeColors["white"]!
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            buildNavigationItem("home", 'Sign Out',
                                screens[4], const StartupScreen()),
                          ],
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
