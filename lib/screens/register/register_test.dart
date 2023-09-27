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

class RegisterTest extends StatefulWidget {
  const RegisterTest({Key? key}) : super(key: key);

  @override
  RegisterTestState createState() => RegisterTestState();
}

class RegisterTestState extends State<RegisterTest>
    with SingleTickerProviderStateMixin {
  late GlobalProvider globalProvider;
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Active', 'Expired'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
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
              //Initial Content of the page
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 80, bottom: 20),
                  child: Column(
                    children: [
                      //Rest of the Content of the section body
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: TabBar(
                          isScrollable: true,
                          controller: _tabController,
                          indicatorColor: Colors.white,
                          indicator: const UnderlineTabIndicator(
                            borderSide:
                                BorderSide(width: 2.0, color: Colors.white),
                            insets: EdgeInsets.symmetric(
                                horizontal: 17.5, vertical: 10),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white.withOpacity(0.3),
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
                      //Content related to the filter
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Content for 'All' filter
                            Center(
                              child: Text('All Insurance Content'),
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
