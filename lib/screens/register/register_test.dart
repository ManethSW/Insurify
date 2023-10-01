// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:insurify/providers/user_provider.dart';
// import 'package:insurify/screens/components/top_bar.dart';
// import 'package:insurify/screens/profile/profile_main_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:insurify/providers/theme_provider.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   TestScreenState createState() => TestScreenState();
// }

// class TestScreenState extends State<TestScreen>
//     with SingleTickerProviderStateMixin {
//   late ThemeProvider themeProvider;
//   late UserDataProvider userDataProvider;
//   bool isOpenFirstName = false;
//   bool isOpenLastName = false;
//   bool isOpenEmail = false;

//   late bool isFirstNameValid;
//   late IconData firstNameValidationIcon;
//   late Color firstNameValidationColor;
//   late bool isLastNameValid;
//   late IconData lastNameValidationIcon;
//   late Color lastNameValidationColor;
//   late bool isEmailValid;
//   late IconData emailValidationIcon;
//   late Color emailValidationColor;

//   final List<TextEditingController> textEditingControllers = List.generate(
//     3,
//     (_) => TextEditingController(),
//   );

//   @override
//   void initState() {
//     super.initState();
//     userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
//     isFirstNameValid = false;
//     firstNameValidationIcon = Icons.close;
//     firstNameValidationColor = Colors.grey;
//     isLastNameValid = false;
//     lastNameValidationIcon = Icons.close;
//     lastNameValidationColor = Colors.grey;
//     isEmailValid = false;
//     emailValidationIcon = Icons.close;
//     emailValidationColor = Colors.grey;
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
//     textEditingControllers[1].text = '';
//     textEditingControllers[2].text = '';
//   }

//   void updateUserData() {
//     userDataProvider.userData.fname = textEditingControllers[0].text;
//     userDataProvider.userData.lname = textEditingControllers[1].text;
//     userDataProvider.userData.email = textEditingControllers[2].text;
//   }

//   Widget buildBuildTextField(
//     TextEditingController controller,
//     String hintText,
//     String label,
//   ) {
//     return TextField(
//       cursorColor: themeProvider.themeColors["white"],
//       cursorOpacityAnimates: true,
//       controller: controller,
//       style: TextStyle(
//         color: themeProvider.themeColors["white"],
//         fontSize: 12.5,
//         fontFamily: 'Inter',
//       ),
//       onChanged: (value) {
//         switch (label) {
//           case 'Updated First Name':
//             setState(() {
//               if (value.isEmpty) {
//                 isFirstNameValid = false;
//                 firstNameValidationIcon = Icons.close_rounded;
//                 firstNameValidationColor = Colors.grey;
//               } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
//                 isFirstNameValid = false;
//                 firstNameValidationIcon = Icons.close_rounded;
//                 firstNameValidationColor = Colors.red;
//               } else {
//                 isFirstNameValid = true;
//                 firstNameValidationIcon = Icons.check;
//                 firstNameValidationColor = Colors.green;
//               }
//             });
//             break;
//           case 'Updated Last Name':
//             setState(() {
//               if (value.isEmpty) {
//                 isLastNameValid = false;
//                 lastNameValidationIcon = Icons.close_rounded;
//                 lastNameValidationColor = Colors.red;
//               } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
//                 isLastNameValid = false;
//                 lastNameValidationIcon = Icons.close_rounded;
//                 lastNameValidationColor = Colors.red;
//               } else {
//                 isLastNameValid = true;
//                 lastNameValidationIcon = Icons.check;
//                 lastNameValidationColor = Colors.green;
//               }
//             });
//             break;
//           case 'Updated Email':
//             setState(() {
//               if (value.isEmpty) {
//                 isEmailValid = false;
//                 emailValidationIcon = Icons.close_rounded;
//                 emailValidationColor = Colors.red;
//               } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                   .hasMatch(value)) {
//                 isEmailValid = false;
//                 emailValidationIcon = Icons.close_rounded;
//                 emailValidationColor = Colors.red;
//               } else {
//                 isEmailValid = true;
//                 emailValidationIcon = Icons.check;
//                 emailValidationColor = Colors.green;
//               }
//             });
//             break;
//         }
//       },
//       textAlign: TextAlign.left,
//       decoration: InputDecoration(
//         focusedBorder: InputBorder.none,
//         enabledBorder: InputBorder.none,
//         border: InputBorder.none,
//         contentPadding: const EdgeInsets.all(0),
//         isDense: true,
//         hintText: hintText,
//         hintStyle: TextStyle(
//           color: themeProvider.themeColors["white"]!.withOpacity(0.75),
//           fontWeight: FontWeight.w400,
//           fontSize: 12.5,
//           fontFamily: 'Inter',
//         ),
//       ),
//     );
//   }

//   Widget buildTextFieldLabel(String label) {
//     return Positioned(
//       top: -7.5,
//       left: 10,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               themeProvider
//                   .themeColors["buttonOne"]!, // replace with your top color
//               themeProvider.themeColors[
//                   "textFieldBackground"]! // replace with your bottom color
//             ],
//             stops: const [0.3, 1.0],
//           ),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             color: themeProvider.themeColors["textFieldBorderAndLabel"],
//             fontWeight: FontWeight.w600,
//             fontSize: 12.5,
//             fontFamily: 'Inter',
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildInputRow(
//       String label,
//       TextEditingController controller,
//       String hintText,
//       IconData validationIcon,
//       Color validationColor) {
//     return Stack(
//       alignment: Alignment.topLeft,
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           height: 47.5,
//           padding: EdgeInsets.symmetric(horizontal: 17.5),
//           decoration: BoxDecoration(
//             color: themeProvider.themeColors["textFieldBackground"],
//             borderRadius: BorderRadius.circular(5),
//             border: Border.all(
//                 color: themeProvider.themeColors["textFieldBorderAndLabel"]!,
//                 width: 2),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: buildBuildTextField(
//                   controller,
//                   hintText,
//                   label,
//                 ),
//               ),
//               Icon(
//                 validationIcon,
//                 size: 20,
//                 color: validationColor,
//               )
//             ],
//           ),
//         ),
//         buildTextFieldLabel("Updated First Name"),
//       ],
//     );
//   }

//   Widget buildEditRow(
//       String label,
//       String editLabel,
//       TextEditingController controller,
//       String hintText,
//       IconData validationIcon,
//       Color validationColor,
//       String currentValue,
//       bool isOpen,
//       VoidCallback onToggleOpen) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 350),
//       curve: Curves.easeInOut,
//       height: isOpen ? 130 : 57.5,
//       padding: const EdgeInsets.only(left: 12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: themeProvider.themeColors["buttonOne"],
//       ),
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           Container(
//             height: 55,
//             margin: const EdgeInsets.only(top: 11.25),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     color:
//                         themeProvider.themeColors["white"]!.withOpacity(0.50),
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12.5,
//                     fontFamily: 'Inter',
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   currentValue,
//                   style: TextStyle(
//                     color: themeProvider.themeColors["white"],
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12.5,
//                     fontFamily: 'Inter',
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SingleChildScrollView(
//             physics: const ClampingScrollPhysics(),
//             child: Container(
//               height: 47.5,
//               margin: EdgeInsets.only(top: 70, right: 12, bottom: 12),
//               child: buildInputRow(
//                 editLabel,
//                 controller,
//                 hintText,
//                 validationIcon,
//                 validationColor,
//               ),
//             ),
//           ),
//           Positioned(
//             right: 0,
//             child: GestureDetector(
//               onTap: onToggleOpen,
//               child: Container(
//                 width: 45,
//                 height: 47.5,
//                 margin: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: themeProvider.themeColors["primary"],
//                 ),
//                 child: Center(
//                   child: AnimatedRotation(
//                     duration: const Duration(milliseconds: 350),
//                     curve: Curves.easeInOut,
//                     turns: isOpen ? 0.25 : 0.75,
//                     child: SvgPicture.asset(
//                       themeProvider.themeIconPaths["backArrow"]!,
//                       width: 10,
//                       height: 10,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     themeProvider = Provider.of<ThemeProvider>(context);
//     userDataProvider = Provider.of<UserDataProvider>(context);
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(
//         statusBarColor: themeProvider.themeColors["buttonOne"],
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
//               buildTopBar(context),
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 95),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: height * 0.05,
//                       ),
//                       //build first name edit row
//                       // Container(
//                       //   padding: EdgeInsets.symmetric(horizontal: 30),
//                       //   child: buildInputRow(
//                       //     "First Name",
//                       //     textEditingControllers[0],
//                       //     "Enter your new first name",
//                       //     132.5,
//                       //     firstNameValidationIcon,
//                       //     firstNameValidationColor,
//                       //   ),
//                       // ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: buildEditRow(
//                           "First Name",
//                           "Updated First Name",
//                           textEditingControllers[0],
//                           "Enter your new first name",
//                           firstNameValidationIcon,
//                           firstNameValidationColor,
//                           userDataProvider.userData.fname!,
//                           isOpenFirstName,
//                           () {
//                             setState(() {
//                               isOpenFirstName =
//                                   !isOpenFirstName; // Toggle the first _isOpen state
//                             });
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.025,
//                       ),
//                       // buildEditRow(
//                       //   "Last Name",
//                       //   "Updated Last Name",
//                       //   textEditingControllers[1],
//                       //   "Enter your new last name",
//                       //   130,
//                       //   lastNameValidationIcon,
//                       //   lastNameValidationColor,
//                       //   userDataProvider.userData.lname!,
//                       //   isOpenLastName,
//                       //   () {
//                       //     setState(() {
//                       //       isOpenLastName =
//                       //           !isOpenLastName; // Toggle the first _isOpen state
//                       //     });
//                       //   },
//                       // ),
//                       // SizedBox(
//                       //   height: height * 0.025,
//                       // ),
//                       // buildEditRow(
//                       //   "Email",
//                       //   "Updated Email",
//                       //   textEditingControllers[2],
//                       //   "Enter your new email",
//                       //   100,
//                       //   emailValidationIcon,
//                       //   emailValidationColor,
//                       //   userDataProvider.userData.email!,
//                       //   isOpenEmail,
//                       //   () {
//                       //     setState(() {
//                       //       isOpenEmail =
//                       //           !isOpenEmail; // Toggle the first _isOpen state
//                       //     });
//                       //   },
//                       // ),
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
