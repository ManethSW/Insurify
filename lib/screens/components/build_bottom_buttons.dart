import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildBackAndNextButtons(
    BuildContext context, double width, Widget pageOne, Widget pageTwo) {
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
                color: const Color(0xFF16161B),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/backward.svg',
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
                color: const Color(0xFF16161B),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Next',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    'assets/icons/forward.svg',
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
