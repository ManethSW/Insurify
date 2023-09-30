// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:insurify/providers/theme_provider.dart';
// import 'package:insurify/providers/user_provider.dart';
// import 'package:insurify/screens/components/build_bottom_buttons.dart';
// import 'package:insurify/screens/register/register_two_screen.dart';
// import 'package:insurify/screens/startup/startup_screen.dart';
// import 'package:provider/provider.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   TestScreenState createState() => TestScreenState();
// }

// class TestScreenState extends State<TestScreen> {
//   late ThemeProvider themeProvider;
//   UserData userData = UserData(
//       fname: '',
//       lname: '',
//       email: '',
//       phoneNo: '',
//       dob: DateTime.now(),
//       gender: '');
//   final TextEditingController controller = TextEditingController();
//   final List<TextEditingController> textEditingControllers = List.generate(
//     6,
//     (_) => TextEditingController(),
//   );

//   @override
//   void initState() {
//     super.initState();
//     setControllers();
//   }

//   @override
//   void dispose() {
//     for (final controller in textEditingControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   void setControllers() {
//     textEditingControllers[0].text = '';
//   }

//   void updateUserData() {
//     userData.fname = textEditingControllers[0].text;
//     print(userData.fname);
//   }

//   Widget buildBuildTextField(TextEditingController controller, String hintText,
//       bool textFieldTyping, bool isEmpty) {
//     return TextField(
//       cursorColor: themeProvider.themeColors["white"],
//       cursorOpacityAnimates: true,
//       controller: controller,
//       style: TextStyle(
//         color: themeProvider.themeColors["white"],
//         fontSize: 14,
//         fontFamily: 'Inter',
//       ),
//       onChanged: (value) {},
//       textAlign: TextAlign.left,
//       decoration: InputDecoration(
//         focusedBorder: InputBorder.none,
//         enabledBorder: InputBorder.none,
//         border: InputBorder.none,
//         contentPadding: const EdgeInsets.all(0),
//         isDense: true,
//         hintText: hintText,
//         enabled: textFieldTyping,
//         hintStyle: TextStyle(
//           color: themeProvider.themeColors["white"],
//           fontWeight: FontWeight.w400,
//           fontSize: 14,
//           fontFamily: 'Inter',
//         ),
//       ),
//     );
//   }

//   Widget buildBuildTextFieldContainer(TextEditingController controller,
//       String hintText, bool textFieldTyping, bool isEmpty) {
//     return Container(
//       height: 47.5,
//       padding: const EdgeInsets.only(
//           left: 16,
//           right: 10,
//           bottom: 0,
//           top: 13.75), // Padding for the TextField
//       decoration: BoxDecoration(
//         color: themeProvider.themeColors["textFieldBackground"],
//         borderRadius: BorderRadius.circular(5),
//         border: Border.all(
//             color: themeProvider.themeColors["textFieldBorderAndLabel"]!,
//             width: 2),
//       ),
//       child:
//           buildBuildTextField(controller, hintText, textFieldTyping, isEmpty),
//     );
//   }

//   Widget buildTextFieldLabel(String label) {
//     return Positioned(
//       top: -8.5,
//       left: 17.5,
//       child: Text(
//         label,
//         style: TextStyle(
//           color: themeProvider.themeColors["textFieldBorderAndLabel"],
//           fontWeight: FontWeight.w600,
//           fontSize: 15,
//           fontFamily: 'Inter',
//         ),
//         textAlign: TextAlign.left,
//       ),
//     );
//   }

//   Widget buildTextFieldLabelBackground(double labelbackgroundwidth) {
//     return Positioned(
//       top: -0.5,
//       left: 7.5,
//       child: Container(
//         height: 10,
//         width: labelbackgroundwidth,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         color: themeProvider.themeColors["textFieldBackground"],
//         // color: Colors.red,
//       ),
//     );
//   }

//   Widget buildInputRow(String label, TextEditingController controller,
//       String hintText, double labelbackgroundwidth, bool textFieldTyping) {
//     bool isValid = false;
//     bool isEmpty = true;
//     return Flexible(
//       child: Stack(
//         alignment: Alignment.topLeft,
//         clipBehavior: Clip.none,
//         children: <Widget>[
//           buildBuildTextFieldContainer(
//               controller, hintText, textFieldTyping, isEmpty),
//           buildTextFieldLabelBackground(labelbackgroundwidth),
//           buildTextFieldLabel(label),
//           Positioned(
//             bottom: -20,
//             right: 0,
//             child: Text(
//               'Please enter your first name',
//               style: TextStyle(
//                 // color: Colors.green,
//                 color: isValid! ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 12,
//                 fontFamily: 'Inter',
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     themeProvider = Provider.of<ThemeProvider>(context);
//     // userDataProvider = Provider.of<UserDataProvider>(context);
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(
//         statusBarColor: themeProvider.themeColors["primary"],
//         systemNavigationBarColor: themeProvider.themeColors["primary"],
//       ),
//     );
//     final double height =
//         MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
//     // width variable of screen
//     final double width =
//         MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: Stack(
//             children: [
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 31, right: 31),
//                   child: Column(
//                     children: [
//                       SizedBox(height: height * 0.075),
//                       buildInputRow('First Name', textEditingControllers[0],
//                           'Enter your first name', 95, true),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
