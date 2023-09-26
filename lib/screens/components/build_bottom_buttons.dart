import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurify/main.dart';
import 'package:provider/provider.dart';

late GlobalProvider globalProvider;

Widget buildBackAndNextButtons(
    BuildContext context, double width, Widget pageOne, Widget pageTwo) {
  globalProvider = Provider.of<GlobalProvider>(context);
  return SizedBox(
    width: width,
    height: 50,
    // color: Colors.white,
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    pageOne,
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
                    child: Container(
                      color: Colors.transparent,
                      child: child,
                    ),
                  );
                },
              ),
            );
          },
          child: SizedBox(
            width: width * 0.2,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                color: globalProvider.themeColors["buttonOne"]!,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  globalProvider.themeIconPaths["backArrow"]!,
                  height: 16,
                  // width: 20,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      pageTwo,
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
                color: globalProvider.themeColors["buttonOne"]!,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Next',
                    style: TextStyle(
                      color: globalProvider.themeColors["white"],
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    globalProvider.themeIconPaths["fowardArrow"]!,
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
  );
}
