/*
* File : Feedback Form
* Version : 1.0.0
* */

import 'package:cargo/providers/cargo_provider.dart';
import 'package:cargo/screens/tracking/shipment_details.dart';
import 'package:cargo/screens/tracking/verification_dialog.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:cargo/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class CargoTrackingScreen extends StatefulWidget {
  const CargoTrackingScreen({Key? key, this.isAgent = false}) : super(key: key);
  final bool isAgent;

  @override
  _CargoTrackingScreenState createState() => _CargoTrackingScreenState();
}

class _CargoTrackingScreenState extends State<CargoTrackingScreen> {
  int? _radioValue = 1;
  late CustomTheme customTheme;
  late ThemeData theme;
  String? trackingNumber;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
          ),
          title: FxText.titleMedium(
              widget.isAgent ? "Track Customers Cargo" : "Track your Cargo",
              fontWeight: 600),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                color: theme.colorScheme.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FxText.titleMedium("Enter Cargo details", fontWeight: 700),
                    Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: FxText.bodyMedium(
                            "Do you want to view cargo details?",
                            fontWeight: 500)),
                    FxText.bodyMedium(
                        widget.isAgent
                            ? "Fill in details below"
                            : "Enter details received via sms",
                        fontWeight: 500),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      trackingNumber = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Tracking number",
                    isDense: true,
                    filled: true,
                    fillColor: theme.colorScheme.background,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 2,
                  maxLines: 3,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: 1,
                      visualDensity: VisualDensity.compact,
                      activeColor: theme.colorScheme.primary,
                      groupValue: _radioValue,
                      onChanged: (int? value) {
                        setState(() {
                          _radioValue = value;
                        });
                      },
                    ),
                    FxText.titleSmall("Air", fontWeight: 600),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Radio(
                        value: 2,
                        visualDensity: VisualDensity.compact,
                        activeColor: theme.colorScheme.primary,
                        groupValue: _radioValue,
                        onChanged: (int? value) {
                          setState(() {
                            _radioValue = value;
                          });
                        },
                      ),
                    ),
                    FxText.titleSmall("Land", fontWeight: 600),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Radio(
                        value: 3,
                        visualDensity: VisualDensity.compact,
                        activeColor: theme.colorScheme.primary,
                        groupValue: _radioValue,
                        onChanged: (int? value) {
                          setState(() {
                            _radioValue = value;
                          });
                        },
                      ),
                    ),
                    FxText.titleSmall("Not Sure", fontWeight: 600),
                  ],
                ),
              ),
              Container(
                margin: FxSpacing.fromLTRB(20, 20, 20, 0),
                child: FxButton.block(
                  onPressed: () async {
                    if (trackingNumber == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: FxText.bodyMedium(
                            "Please enter tracking number",
                            color: Colors.white,
                            fontWeight: 500),
                        backgroundColor: theme.colorScheme.error,
                      ));
                      return;
                    }

                    if (widget.isAgent) {
                      await Provider.of<CargoProvider>(context, listen: false)
                          .fetchUserCargo(trackingNumber!)
                          .then((value) =>
                              Get.off(() => ShipmentDetails(cargo: value)));
                    } else {
                      try {
                        await Provider.of<CargoProvider>(context, listen: false)
                            .getShipment(trackingNumber!);
                        showDialog(
                            context: context,
                            builder: (ctx) => const VerificationDialog());
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Something went wrong"),
                        ));
                      }
                    }
                  },
                  elevation: 0,
                  child: FxText.bodyLarge("Track Cargo",
                      color: theme.colorScheme.onSecondary),
                  borderRadiusAll: 4,
                ),
              ),
            ],
          ),
        ));
  }
}
