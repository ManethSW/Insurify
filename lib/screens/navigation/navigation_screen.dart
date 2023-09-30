import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurify/main.dart';
import 'package:insurify/screens/components/startup_screen_heading.dart';
import 'package:insurify/screens/login/login_one_screen.dart';
import 'package:insurify/screens/register/register_three_screen.dart';
import 'package:pinput/pinput.dart';

import 'package:flutter/services.dart';
import 'package:insurify/screens/components/build_bottom_buttons.dart';
import 'package:insurify/screens/register/register_one_screen.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen> {
  late GlobalProvider globalProvider;

  Widget buildNavigationItem(String icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding:
            const EdgeInsets.only(left: 15, top: 10, right: 20, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon(
            //   icon,
            //   color: globalProvider.themeColors["white"],
            //   size: 30,
            // ),
            Image.asset(
              globalProvider.themeIconPaths[icon]!,
              height: 22.5,
              width: 22.5,
            ),
            const SizedBox(width: 20),
            Text(
              label,
              style: TextStyle(
                fontSize: 17.5,
                fontWeight: FontWeight.w400,
                color: globalProvider.themeColors["white"],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    globalProvider = Provider.of<GlobalProvider>(context);
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    // width variable of screen
    final double width =
        MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Scaffold(
          backgroundColor: globalProvider.themeColors["navigationBackground"],
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned(
                bottom: 160,
                left: 31,
                right: 31,
                child: TextButton(
                  onPressed: () {
                    globalProvider.toggleTheme();
                  },
                  child: const Text('Change Theme'),
                ),
              ),
              Positioned(
                top: 60,
                right: 20,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.close_rounded),
                  color: globalProvider.themeColors["white"],
                  iconSize: 35,
                ),
              ),
              Positioned(
                top: 120,
                right: 0,
                child: Image.asset(
                  globalProvider.themeIconPaths["homePage"]!,
                  // height: 100,
                  width: 90,
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
                              padding: EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 36.5,
                                    backgroundColor: globalProvider
                                        .themeColors["white"]!
                                        .withOpacity(0.5),
                                    child: CircleAvatar(
                                      radius: 35.0,
                                      backgroundImage: Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/the-wallet-2fa7c.appspot.com/o/files%2F032a0ee8-6075-4e49-8c66-1ddf11ebc876_wp7782555.jpg?alt=media&token=60263346-268c-48c4-a672-2fd6410a1c77')
                                          .image,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.025),
                                  Text(
                                    'Good Morning',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: globalProvider
                                          .themeColors["white"]!
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.015),
                                  Text(
                                    'Maneth Weerasinghe',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          globalProvider.themeColors["white"],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 10, right: 20, bottom: 10),
                                // width: ,
                                // height: 50,
                                decoration: BoxDecoration(
                                  color: globalProvider
                                      .themeColors["navigationActive"],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      globalProvider.themeIconPaths["profile"]!,
                                      height: 22.5,
                                      width: 22.5,
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      'Profile',
                                      style: TextStyle(
                                        fontSize: 17.5,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            globalProvider.themeColors["white"],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            buildNavigationItem("home", 'Home'),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            buildNavigationItem("plus", 'Add New Insurance'),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            buildNavigationItem("blog", 'View Blogs'),
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
                              margin: EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                color: globalProvider.themeColors["white"]!
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            buildNavigationItem("signout", 'Sign Out'),
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
