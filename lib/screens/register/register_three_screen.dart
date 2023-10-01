import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:insurify/providers/theme_provider.dart';
import 'package:insurify/screens/login/login_one_screen.dart';

class RegisterThreeScreen extends StatefulWidget {
  const RegisterThreeScreen({Key? key}) : super(key: key);

  @override
  RegisterThreeScreenState createState() => RegisterThreeScreenState();
}

class RegisterThreeScreenState extends State<RegisterThreeScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeProvider.themeColors["primary"],
        systemNavigationBarColor:
            themeProvider.themeColors["primary"],
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
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: height * 0.2),
                      SvgPicture.asset(
                        'assets/icons/checkmark.svg',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      const SizedBox(
                        width: 175,
                        child: Text(
                          "Account Created Successfully",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF3A9D62),
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 90,
                left: width * 0.1,
                right: width * 0.1,
                child: Text(
                  "Please login to access the application",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        themeProvider.themeColors["textFieldBorderAndLabel"],
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              Positioned(
                bottom: 31,
                left: 31,
                right: 31,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const LoginOneScreen(),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            color: themeProvider.themeColors["white"],
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          themeProvider.themeIconPaths["fowardArrow"]!,
                          width: 12,
                          height: 12,
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
