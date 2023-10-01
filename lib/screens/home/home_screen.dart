import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurify/screens/components/policy_card.dart';
import 'package:insurify/screens/components/top_bar.dart';
import 'package:insurify/screens/navigation/navigation_screen.dart';
import 'package:provider/provider.dart';

import 'package:insurify/providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late ThemeProvider themeProvider;
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
          color: themeProvider.themeColors["buttonOne"],
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
                  color: themeProvider.themeColors["white"],
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
                  color: themeProvider.themeColors["startUpBodyText"],
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
                      color: themeProvider.themeColors["primary"],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      color: themeProvider.themeColors["white"],
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

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeProvider.themeColors["buttonOne"],
        systemNavigationBarColor: themeProvider.themeColors["primary"],
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
              buildTopBar(context),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 90, bottom: 20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: themeProvider.themeColors["buttonOne"],
                        child: Icon(Icons.person_rounded,
                            color: themeProvider.themeColors["white"],
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
                          color: themeProvider.themeColors["white"],
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
                            color: themeProvider.themeColors["white"],
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
                            color: themeProvider.themeColors["white75"],
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
                              borderSide: BorderSide(
                                  width: 2.0,
                                  color: themeProvider.themeColors["white"]!),
                              insets: const EdgeInsets.symmetric(
                                  horizontal: 17.5, vertical: 10),
                            ),
                            labelPadding: EdgeInsets.only(left: 5, right: 5),
                            labelColor: themeProvider.themeColors["white"],
                            unselectedLabelColor: themeProvider
                                .themeColors["white"]!
                                .withOpacity(0.5),
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
                          children: const [
                            // Content for 'All' filter
                            GlowingOverscrollIndicator(
                              axisDirection: AxisDirection.down,
                              color: Colors.black,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    PolicyCardTemplate(
                                      policyStatus: 'due',
                                        policyName: 'Basic Motor Insurance',
                                        policyRate: 'LKR 25,0000',
                                        policyRatePeriod: 'year',
                                        policyId: 'ABC123456789',
                                        totalPaid: 'LKR 125,000',
                                        paymentDue: '02/10/2024',
                                        policyClientName: 'Maneth Weerasinghe',
                                        policyClientNicNo: '20032760568',
                                        policyClienDob: '01/06/2023',
                                        policyClientAddress:
                                            '27/A, Walawatta Place, Galpotta Road\nNawala, Western Province',
                                        policyClientVehicleMake: 'Toyota',
                                        policyClientVehicleModel: 'Corolla',
                                        policyClientVehicleRegistratioNo:
                                            'WP 1234'),
                                    // buildPersonalPolicyCard(
                                    //   themeProvider
                                    //       .themeIconPaths["basicInsurance"]!,
                                    //   "LKR 25,000 / mo",
                                    //   "ABC123456789",
                                    //   "Basic Motor Insurance",
                                    //   themeProvider.themeIconPaths["expire"]!,
                                    //   "LKR 125,000 Paid",
                                    // ),
                                    // const SizedBox(
                                    //   height: 15,
                                    // ),
                                    // buildPersonalPolicyCard(
                                    //   themeProvider
                                    //       .themeIconPaths["basicInsurance"]!,
                                    //   "LKR 25,000 / mo",
                                    //   "ABC123456789",
                                    //   "Basic Motor Insurance",
                                    //   themeProvider.themeIconPaths["expire"]!,
                                    //   "LKR 125,000 Paid",
                                    // ),
                                    // const SizedBox(
                                    //   height: 15,
                                    // ),
                                    // buildPersonalPolicyCard(
                                    //   themeProvider
                                    //       .themeIconPaths["basicInsurance"]!,
                                    //   "LKR 25,000 / mo",
                                    //   "ABC123456789",
                                    //   "Basic Motor Insurance",
                                    //   themeProvider.themeIconPaths["expire"]!,
                                    //   "LKR 125,000 Paid",
                                    // ),
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
            ],
          ),
        ),
      ),
    );
  }
}
