import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurify/providers/theme_provider.dart';
import 'package:insurify/screens/navigation/navigation_screen.dart';
import 'package:provider/provider.dart';

Widget buildTopBar(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context); 
  return Positioned(
    top: 0,
    left: 0,
    right: 0,
    child: Container(
      height: 70,
      decoration: BoxDecoration(
        color: themeProvider.themeColors["buttonOne"],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        NavigationScreen(),
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
              },
              child: SvgPicture.asset(
                themeProvider.themeIconPaths["menu"]!,
                height: 30,
                width: 30,
              ),
            ),
            Image.asset(
              themeProvider.themeIconPaths["smallLogo"]!,
              height: 30,
            ),
          ],
        ),
      ),
    ),
  );
}
