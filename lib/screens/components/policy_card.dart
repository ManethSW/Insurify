import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurify/providers/theme_provider.dart';
import 'package:provider/provider.dart';

typedef DeleteCatdCallBack = Future<void> Function(int cardNo);

class PolicyCardTemplate extends StatefulWidget {
  final String policyStatus;
  final String policyName;
  final String policyRate;
  final String policyRatePeriod;
  final String policyId;
  final String totalPaid;
  final String paymentDue;
  final String policyClientName;
  final String policyClientNicNo;
  final String policyClienDob;
  final String policyClientAddress;
  final String policyClientVehicleMake;
  final String policyClientVehicleModel;
  final String policyClientVehicleRegistratioNo;

  const PolicyCardTemplate({
    super.key,
    required this.policyStatus,
    required this.policyName,
    required this.policyRate,
    required this.policyRatePeriod,
    required this.policyId,
    required this.totalPaid,
    required this.paymentDue,
    required this.policyClientName,
    required this.policyClientNicNo,
    required this.policyClienDob,
    required this.policyClientAddress,
    required this.policyClientVehicleMake,
    required this.policyClientVehicleModel,
    required this.policyClientVehicleRegistratioNo,
  });

  @override
  PolicyCardTemplateState createState() => PolicyCardTemplateState();
}

class PolicyCardTemplateState extends State<PolicyCardTemplate>
    with SingleTickerProviderStateMixin {
  late ThemeProvider themeProvider;

  Widget buildTextHeader(String label) {
    return Text(
      label,
      style: TextStyle(
        color: themeProvider.themeColors["white"],
        fontWeight: FontWeight.w600,
        fontSize: 17.5,
        fontFamily: 'Inter',
      ),
    );
  }

  Widget buildCardHeaderRateAndId(Color background, String label) {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        height: 25,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: themeProvider.themeColors["white"],
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  Widget buildCardHeader(Color background) {
    return Row(
      children: [
        CircleAvatar(
          radius: 17,
          backgroundColor: background,
          child:
              SvgPicture.asset(themeProvider.themeIconPaths["basicInsurance"]!),
        ),
        const SizedBox(
          width: 10,
        ),
        buildCardHeaderRateAndId(
            background, '${widget.policyRate} / ${widget.policyRatePeriod}'),
        const SizedBox(
          width: 10,
        ),
        buildCardHeaderRateAndId(background, widget.policyId),
      ],
    );
  }

  Widget buildPolicyStausIcon(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (widget.policyStatus == 'due' || widget.policyStatus == 'payed') {
          return SvgPicture.asset(
            themeProvider.themeIconPaths["active"]!,
            height: 17.5,
          );
        } else {
          return SvgPicture.asset(
            themeProvider.themeIconPaths["inactive"]!,
            height: 17.5,
          );
        }
      },
    );
  }

  Widget buildPolicyDetail(String label, String detail) {
    if (detail == "mo") {
      detail = "Monthly";
    } else if (detail == "year") {
      detail = "Yearly";
    }
    return Row(
      children: [
        label == "Expire Date"
            ? Container()
            : Container(
                width: 3,
                height: label == "Address" ? 47.5 : 32.5,
                decoration: BoxDecoration(
                  color:
                      themeProvider.themeColors["buttonOne"]!.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
        label == "Expire Date"
            ? const SizedBox(
                width: 0,
              )
            : const SizedBox(
                width: 10,
              ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: themeProvider.themeColors["white"]!.withOpacity(0.75),
                fontWeight: FontWeight.w400,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              detail,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: themeProvider.themeColors["white"]!.withOpacity(1),
                fontWeight: FontWeight.w500,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPolicyDetailRow(String labelOne, String detailOne,
      String labelTwo, String detailTwo, double width) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: buildPolicyDetail(labelOne, detailOne),
        ),
        SizedBox(
          width: width,
        ),
        Expanded(
          flex: 1,
          child: buildPolicyDetail(labelTwo, detailTwo),
        ),
      ],
    );
  }

  Widget buildPolicyCardOverlayButton(Function() tapFunction, String label) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: tapFunction,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7.5),
          decoration: BoxDecoration(
            color: themeProvider.themeColors["buttonOne"],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: themeProvider.themeColors["white"],
                fontWeight: FontWeight.w400,
                fontSize: 13.5,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPolicyCardOverlayCloseButton(
    Function() tapFunction,
  ) {
    return GestureDetector(
      onTap: tapFunction,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 12.5),
        decoration: BoxDecoration(
          color: themeProvider.themeColors["buttonOne"],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(
            Icons.close_rounded,
            size: 17.5,
            color: themeProvider.themeColors["white"],
          ),
        ),
      ),
    );
  }

  Widget buildPolicyCardOverlayOne(double width) {
    return SizedBox(
      width: width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 12, right: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildCardHeader(themeProvider.themeColors["buttonOne"]!),
                const SizedBox(
                  height: 15,
                ),
                buildTextHeader(widget.policyName),
                Text(
                  widget.policyName,
                  style: TextStyle(
                    color: themeProvider.themeColors["white"],
                    fontWeight: FontWeight.w600,
                    fontSize: 17.5,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  '${widget.totalPaid} Paid',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: themeProvider.themeColors["startUpBodyText"],
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 6, top: 6, right: 2.5, bottom: 5),
                            decoration: BoxDecoration(
                              color: themeProvider.themeColors["buttonOne"],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: buildPolicyStausIcon(context),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          buildPolicyDetail('Expire Date', widget.paymentDue),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Expanded(
                      flex: 1,
                      child: buildPolicyDetail(
                          'Client Name', widget.policyClientName),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                buildPolicyDetailRow('NIC Number', widget.policyClientNicNo,
                    'Date of Birth', widget.policyClienDob, width * 0.05),
                const SizedBox(
                  height: 25,
                ),
                buildPolicyDetail('Address', widget.policyClientAddress),
                const SizedBox(
                  height: 25,
                ),
                buildPolicyDetailRow(
                    'Vehicle Make',
                    widget.policyClientVehicleMake,
                    'Vehicle Model',
                    widget.policyClientVehicleModel,
                    width * 0.05),
                const SizedBox(
                  height: 25,
                ),
                buildPolicyDetail('Vehicle Registration Number',
                    widget.policyClientVehicleRegistratioNo),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Row(
            children: [
              buildPolicyCardOverlayButton(
                () {
                  print('payment');
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Second Overlay Title'),
                        content: Text('Second Overlay Content'),
                      );
                    },
                  );
                },
                "Payment",
              ),
              const SizedBox(
                width: 8,
              ),
              buildPolicyCardOverlayButton(
                () {
                  print('update');
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Second Overlay Title'),
                        content: Text('Second Overlay Content'),
                      );
                    },
                  );
                },
                "Update Policy",
              ),
              const SizedBox(
                width: 8,
              ),
              buildPolicyCardOverlayCloseButton(
                () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildDivider() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          color: themeProvider.themeColors["white"]!.withOpacity(0.25),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget buildPolicyCardOverlayTwo(double width) {
    return SizedBox(
      width: width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 12, right: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildCardHeader(themeProvider.themeColors["buttonOne"]!),
                const SizedBox(
                  height: 15,
                ),
                buildTextHeader(widget.policyName),
                Text(
                  '${widget.totalPaid} Paid',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: themeProvider.themeColors["startUpBodyText"],
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                buildDivider(),
                const SizedBox(
                  height: 20,
                ),
                buildTextHeader("Invoice Summary"),
                const SizedBox(
                  height: 20,
                ),
                buildPolicyDetailRow("Policy Rate", widget.policyRate,
                    "Policy ID", widget.policyId, width * 0.05),
                const SizedBox(
                  height: 20,
                ),
                buildPolicyDetail("Next Payment Amount", widget.policyRate),
                const SizedBox(
                  height: 20,
                ),
                buildDivider(),
                const SizedBox(
                  height: 20,
                ),
                buildTextHeader("Card Details"),
              ],
            ),
          ),
          Row(
            children: [
              buildPolicyCardOverlayButton(
                () {
                  print('payment');
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Second Overlay Title'),
                        content: Text('Second Overlay Content'),
                      );
                    },
                  );
                },
                "Payment",
              ),
              const SizedBox(
                width: 8,
              ),
              buildPolicyCardOverlayButton(
                () {
                  print('update');
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Second Overlay Title'),
                        content: Text('Second Overlay Content'),
                      );
                    },
                  );
                },
                "Update Policy",
              ),
              const SizedBox(
                width: 8,
              ),
              buildPolicyCardOverlayCloseButton(
                () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    final double width =
        MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left;
    return Stack(
      children: [
        Container(
          height: 156,
          decoration: BoxDecoration(
            color: themeProvider.themeColors["buttonOne"],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                buildCardHeader(themeProvider.themeColors["primary"]!),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    buildTextHeader(widget.policyName),
                    const SizedBox(
                      width: 10,
                    ),
                    LayoutBuilder(builder: (context, constraints) {
                      if (widget.policyStatus == 'due' ||
                          widget.policyStatus == 'payed') {
                        return SvgPicture.asset(
                          themeProvider.themeIconPaths["active"]!,
                          height: 17.5,
                        );
                      } else {
                        return SvgPicture.asset(
                          themeProvider.themeIconPaths["inactive"]!,
                          height: 17.5,
                        );
                      }
                    }),
                  ],
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: Text(
                    '${widget.totalPaid} Paid',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: themeProvider.themeColors["startUpBodyText"],
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    String period =
                        widget.policyRatePeriod == "mo" ? "month" : "year";
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.policyStatus == "due"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Next payment due",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color:
                                            themeProvider.themeColors["white"],
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    Text(
                                      widget.paymentDue,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: themeProvider
                                            .themeColors["startUpBodyText"],
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                )
                              : widget.policyStatus == "payed"
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Payment Made for\nnext $period",
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            color: Color(0xFF3A9D62),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Text(
                                      'Your insurance policy has\nexpired please make next payment',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Color(0xFFBD4343),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.65),
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    insetPadding: EdgeInsets.zero,
                    actionsPadding: EdgeInsets.zero,
                    backgroundColor: themeProvider.themeColors["primary"],
                    clipBehavior: Clip.hardEdge,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Change this value to change the border radius
                    ),
                    content: buildPolicyCardOverlayTwo(width),
                  );
                },
              );
            },
            child: Container(
              width: 50,
              padding: const EdgeInsets.all(12.5),
              // height: 50,
              decoration: BoxDecoration(
                color: themeProvider.themeColors["primary"],
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                themeProvider.themeIconPaths["forwardArrowHead"]!,
                width: 12.5,
                height: 12.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
