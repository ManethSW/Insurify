import 'package:flutter/material.dart';
import 'package:insurify/screens/login/login_one_screen.dart';
import 'package:provider/provider.dart';

import 'package:insurify/providers/theme_provider.dart';
import 'package:insurify/screens/register/register_one_screen.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  late ThemeProvider themeProvider;

  Widget buildButton(BuildContext context, String text, Widget page) {
    final width = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: () {
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
        );
      },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(Size(width * 0.8, 50)),
        backgroundColor: MaterialStateProperty.all<Color>(
          themeProvider.themeColors["secondary"]!,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: themeProvider.themeColors["white"],
          fontSize: 15,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Builder(
      builder: (context) {
        themeProvider = Provider.of<ThemeProvider>(context);
        return Scaffold(
          body: SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.2),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            themeProvider.themeIconPaths["mainLogo"]!,
                            width: 170,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 175,
                            child: Text(
                              'One Stop Shop For All Your Motor Insurance Needs',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: themeProvider
                                    .themeColors["startUpBodyText"],
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 31,
                    left: 31,
                    right: 31,
                    child: Column(
                      children: [
                        buildButton(context, 'Create an Account',
                            const RegisterOneScreen()),
                        const SizedBox(
                          height: 18,
                        ),
                        buildButton(context, 'Login', const LoginOneScreen()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
