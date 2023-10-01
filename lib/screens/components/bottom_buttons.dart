import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:insurify/providers/theme_provider.dart';

late ThemeProvider themeProvider;

Widget buildBackAndNextButtons(BuildContext context, double width,
Widget page, Function beforeNavigationPush) {
  themeProvider = Provider.of<ThemeProvider>(context);
  return SizedBox(
    width: width,
    height: 50,
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            width: width * 0.2,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                color: themeProvider.themeColors["secondary"]!,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  themeProvider.themeIconPaths["backArrow"]!,
                  height: 16,
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
              beforeNavigationPush();
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: themeProvider.themeColors["secondary"]!,
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
  );
}

Widget buildBackButton(BuildContext context, double width) {
  themeProvider = Provider.of<ThemeProvider>(context);
  return SizedBox(
    width: width,
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            width: width * 0.2,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                color: themeProvider.themeColors["secondary"]!,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  themeProvider.themeIconPaths["backArrow"]!,
                  height: 16,
                  // width: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Widget buildBackButton(BuildContext context, double width) {
//   themeProvider = Provider.of<ThemeProvider>(context);
//   return GestureDetector(
//     onTap: () {
//       Navigator.pop(context);
//     },
//     child: SizedBox(
//       width: width * 0.2,
//       height: 50,
//       child: Container(
//         decoration: BoxDecoration(
//           color: themeProvider.themeColors["secondary"]!,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Center(
//           child: SvgPicture.asset(
//             themeProvider.themeIconPaths["backArrow"]!,
//             height: 16,
//           ),
//         ),
//       ),
//     ),
//   );
// }