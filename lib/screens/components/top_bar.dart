import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurify/providers/theme_provider.dart';
import 'package:insurify/screens/navigation/navigation_screen.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  @override
  TopBarState createState() => TopBarState();
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: themeProvider.themeColors["secondary"],
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
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const NavigationScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(-1.0, 0.0);
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
                    setState(() {
                      print('object');
                    });
                  });
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
}