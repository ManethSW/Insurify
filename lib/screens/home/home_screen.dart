import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurify/main.dart';
import 'package:insurify/screens/components/startup_screen_heading.dart';
import 'package:insurify/screens/register/register_three_screen.dart';
import 'package:pinput/pinput.dart';

import 'package:flutter/services.dart';
import 'package:insurify/screens/components/build_bottom_buttons.dart';
import 'package:insurify/screens/register/register_one_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late GlobalProvider globalProvider;
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Active', 'Expired'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  Widget buildQuickActionButton(int flexNumber, String label, IconData icon) {
    return Expanded(
      flex: flexNumber,
      child: Container(
        height: 102,
        decoration: BoxDecoration(
          color: globalProvider.themeColors["buttonOne"],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Text(
                label,
                style: TextStyle(
                  color: globalProvider.themeColors["white"],
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const SizedBox(
              height: 7.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                height: 2,
                width: 25,
                decoration: BoxDecoration(
                  color: globalProvider.themeColors["startUpBodyText"],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 7.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 34,
                    decoration: BoxDecoration(
                      color: globalProvider.themeColors["primary"],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      color: globalProvider.themeColors["white"],
                      // size: 1,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPersonalPolicyCard(
      String policyIconPath,
      String monthlyRate,
      String policyID,
      String policyName,
      String expireIconPath,
      String totalPaidAmount) {
    return Stack(
      children: [
        Container(
          height: 156,
          decoration: BoxDecoration(
            color: globalProvider.themeColors["buttonOne"],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 17,
                      backgroundColor: globalProvider.themeColors["primary"],
                      child: SvgPicture.asset(policyIconPath),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        decoration: BoxDecoration(
                          color: globalProvider.themeColors["primary"],
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          monthlyRate,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: globalProvider.themeColors["white"],
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        decoration: BoxDecoration(
                          color: globalProvider.themeColors["primary"],
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          policyID,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: globalProvider.themeColors["white"],
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      policyName,
                      style: TextStyle(
                        color: globalProvider.themeColors["white"],
                        fontWeight: FontWeight.w600,
                        fontSize: 17.5,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      expireIconPath,
                      height: 17.5,
                    ),
                  ],
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: Text(
                    "LKR 125,000 Paid",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: globalProvider.themeColors["startUpBodyText"],
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: Text(
                    "Next payment due",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: globalProvider.themeColors["white"],
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: Text(
                    "10/06/2023",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: globalProvider.themeColors["startUpBodyText"],
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 50,
              padding: EdgeInsets.all(10),
              // height: 50,
              decoration: BoxDecoration(
                color: globalProvider.themeColors["primary"],
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                globalProvider.themeIconPaths["forwardArrowHead"]!,
                width: 15,
                height: 15,
              ),
            ),
          ),
        ),
      ],
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
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: globalProvider.themeColors["buttonOne"],
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
                          onTap: () {},
                          child: SvgPicture.asset(
                            globalProvider.themeIconPaths["menu"]!,
                            height: 30,
                            width: 30,
                          ),
                        ),
                        Image.asset(
                          globalProvider.themeIconPaths["smallLogo"]!,
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 90, bottom: 20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor:
                            globalProvider.themeColors["buttonOne"],
                        child: Icon(Icons.person_rounded,
                            color: globalProvider.themeColors["white"],
                            size: 40.0),
                        // child: CircleAvatar(
                        //   radius: 41.5,
                        //   backgroundColor: const Color(0xB3000000),
                        //   child: CircleAvatar(
                        //     radius: 40.0,
                        //     backgroundImage: Image.network('').image,
                        //   ),
                        // ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Maneth Weerasinghe",
                        style: TextStyle(
                          color: globalProvider.themeColors["white"],
                          fontWeight: FontWeight.w600,
                          fontSize: 22.5,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildQuickActionButton(
                              2, "Add New \nMotor Insurance", Icons.add),
                          const SizedBox(
                            width: 10,
                          ),
                          buildQuickActionButton(
                              1, "View Profile", Icons.person),
                          const SizedBox(
                            width: 10,
                          ),
                          buildQuickActionButton(
                              1, "View Blogs", Icons.message_rounded),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: Text(
                          "My Insurances",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: globalProvider.themeColors["white"],
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: Text(
                          "View & Manage Your Insurances",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: globalProvider.themeColors["white75"],
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          alignment: Alignment
                              .centerLeft, // Align the TabBar to the left
                          // padding: EdgeInsets.only(left: 0),
                          child: TabBar(
                            isScrollable: true,
                            controller: _tabController,
                            indicator: UnderlineTabIndicator(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(width: 2.0, color: globalProvider.themeColors["white"]!),
                              insets: const EdgeInsets.symmetric(
                                  horizontal: 17.5, vertical: 10),
                            ),
                            labelPadding: EdgeInsets.only(left: 5, right: 5),
                            labelColor: globalProvider.themeColors["white"],
                            unselectedLabelColor: globalProvider.themeColors["white"]!.withOpacity(0.5),
                            labelStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Inter',
                            ),
                            tabs: _tabs
                                .map((String name) => Tab(text: name))
                                .toList(),
                          ),
                        ),
                      ),
                      //Content related to the filter
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Content for 'All' filter
                            GlowingOverscrollIndicator(
                              axisDirection: AxisDirection.down,
                              color: Colors.black,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    buildPersonalPolicyCard(
                                      globalProvider
                                          .themeIconPaths["basicInsurance"]!,
                                      "LKR 25,000 / mo",
                                      "ABC123456789",
                                      "Basic Motor Insurance",
                                      globalProvider.themeIconPaths["expire"]!,
                                      "LKR 125,000 Paid",
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    buildPersonalPolicyCard(
                                      globalProvider
                                          .themeIconPaths["basicInsurance"]!,
                                      "LKR 25,000 / mo",
                                      "ABC123456789",
                                      "Basic Motor Insurance",
                                      globalProvider.themeIconPaths["expire"]!,
                                      "LKR 125,000 Paid",
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    buildPersonalPolicyCard(
                                      globalProvider
                                          .themeIconPaths["basicInsurance"]!,
                                      "LKR 25,000 / mo",
                                      "ABC123456789",
                                      "Basic Motor Insurance",
                                      globalProvider.themeIconPaths["expire"]!,
                                      "LKR 125,000 Paid",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Content for 'Active' filter
                            Center(
                              child: Text('Active Insurance Content'),
                            ),
                            // Content for 'Expired' filter
                            Center(
                              child: Text('Expired Insurance Content'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
