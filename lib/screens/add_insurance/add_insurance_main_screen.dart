import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurify/screens/components/top_bar.dart';
import 'package:provider/provider.dart';

import 'package:insurify/providers/theme_provider.dart';

class AddInsuranceMainScreen extends StatefulWidget {
  const AddInsuranceMainScreen({Key? key}) : super(key: key);

  @override
  AddInsuranceMainScreenState createState() => AddInsuranceMainScreenState();
}

class AddInsuranceMainScreenState extends State<AddInsuranceMainScreen>
    with SingleTickerProviderStateMixin {
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeProvider.themeColors["secondary"],
        systemNavigationBarColor:
            themeProvider.themeColors["primary"],
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
              TopBar(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Column(
                    children: [
                      Text(
                        'Add Insurance Page',
                        style: TextStyle(
                          color: themeProvider.themeColors["white"],
                          fontWeight: FontWeight.w600,
                          fontSize: 17.5,
                          fontFamily: 'Inter',
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
