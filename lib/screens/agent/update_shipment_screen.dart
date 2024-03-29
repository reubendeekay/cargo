// ignore_for_file: use_build_context_synchronously

import 'package:cargo/constants.dart';
import 'package:cargo/helpers/my_loader.dart';
import 'package:cargo/models/cargo_model.dart';
import 'package:cargo/providers/cargo_provider.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:cargo/theme/custom_theme.dart';
import 'package:cargo/widgets/my_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class UpdateShipmentScreen extends StatefulWidget {
  const UpdateShipmentScreen({Key? key}) : super(key: key);

  @override
  State<UpdateShipmentScreen> createState() => _UpdateShipmentScreenState();
}

class _UpdateShipmentScreenState extends State<UpdateShipmentScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  TextEditingController? trackingNumber = TextEditingController();
  FocusNode? focusNode;
  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  TextEditingController status = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController shippingFee = TextEditingController();

  final options = [
    "Shipment received at",
    "Shipment loaded on",
    "Shipment on its way to",
    "Arrived at ",
    "Delivered at",
  ];
  bool isArrived = false;

  String? paymentMode;
  String? shippingMode;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: theme.colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
        title: FxText.titleMedium("Update Shipment", fontWeight: 600),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(
            height: 15,
          ),
          FxText.bodyLarge("Cargo information",
              fontWeight: 600, letterSpacing: 0),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: trackingNumber!,
                    focusNode: focusNode,
                    style: FxTextStyle.titleSmall(
                        letterSpacing: 0,
                        color: theme.colorScheme.onBackground,
                        fontWeight: 500),
                    decoration: InputDecoration(
                      hintText: "Tracking Number",
                      hintStyle: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: customTheme.card,
                      prefixIcon: const Icon(
                        MdiIcons.briefcaseOutline,
                        size: 22,
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(0),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    focusNode!.unfocus();
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: customTheme.card,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: kPrimaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          if (trackingNumber != null && trackingNumber!.text.length > 13)
            EnhancedFutureBuilder(
                future: Provider.of<CargoProvider>(context, listen: false)
                    .fetchUserCargo(trackingNumber!.text.trim()),
                rememberFutureResult: true,
                whenNotDone: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: MyLoader(
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                whenDone: (CargoModel carg) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          FxText.titleMedium(
                            'Tracking Info'.toUpperCase(),
                            fontWeight: 700,
                          ),
                          const Spacer(),
                          FxText.bodySmall(
                            carg.deliveryDate == null
                                ? 'No delivery date set'
                                : carg.deliveryDate!
                                            .toDate()
                                            .difference(DateTime.now())
                                            .inDays <
                                        1
                                    ? 'Delivered'
                                    : '${carg.deliveryDate!.toDate().difference(DateTime.now()).inDays} days left',
                            color: Colors.green,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 4,
                                blurRadius: 10,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(children: [
                            trackingWidget(
                                carg.origin!,
                                'Tracking No: '
                                '${carg.docNo!.replaceAll('_', '/')}'),
                            const SizedBox(height: 20),
                            trackingWidget(carg.destination!,
                                'Description: ${carg.packageName!}'),
                          ]),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        child: FxText.bodyLarge("Cargo Status",
                            fontWeight: 600, letterSpacing: 0),
                      ),
                      MyDropDown(
                          selectedOption: (val) {
                            status = TextEditingController(text: val);
                            setState(() {
                              isArrived = val.contains('rrive');
                            });
                          },
                          hintText:
                              status.text.isNotEmpty ? status.text : 'Status',
                          options: options),
                      if (isArrived)
                        MyDropDown(
                            selectedOption: (val) {
                              setState(() {
                                shippingMode = val;
                              });
                            },
                            hintText: 'Shipping method',
                            options: const [
                              'Sea',
                              'Air',
                            ]),
                      if (isArrived)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          margin: const EdgeInsets.only(top: 5),
                          child: TextFormField(
                            controller: weight,
                            keyboardType: TextInputType.number,
                            style: FxTextStyle.titleSmall(
                                letterSpacing: 0,
                                color: theme.colorScheme.onBackground,
                                fontWeight: 500),
                            decoration: InputDecoration(
                              hintText:
                                  "Weight in ${shippingMode == 'Sea' ? 'CPM' : 'Kg'}",
                              hintStyle: FxTextStyle.titleSmall(
                                  letterSpacing: 0,
                                  color: theme.colorScheme.onBackground,
                                  fontWeight: 500),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide.none),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide.none),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: customTheme.card,
                              prefixIcon: const Icon(
                                MdiIcons.weight,
                                size: 22,
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                      if (isArrived)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          margin: const EdgeInsets.only(top: 12),
                          child: TextFormField(
                            controller: shippingFee,
                            keyboardType: TextInputType.number,
                            style: FxTextStyle.titleSmall(
                                letterSpacing: 0,
                                color: theme.colorScheme.onBackground,
                                fontWeight: 500),
                            decoration: InputDecoration(
                              hintText: "Shipping Fee",
                              hintStyle: FxTextStyle.titleSmall(
                                  letterSpacing: 0,
                                  color: theme.colorScheme.onBackground,
                                  fontWeight: 500),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide.none),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide.none),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: customTheme.card,
                              prefixIcon: const Icon(
                                MdiIcons.cash,
                                size: 22,
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        margin: const EdgeInsets.only(top: 12),
                        child: TextFormField(
                          controller: location,
                          style: FxTextStyle.titleSmall(
                              letterSpacing: 0,
                              color: theme.colorScheme.onBackground,
                              fontWeight: 500),
                          decoration: InputDecoration(
                            hintText: "Location",
                            hintStyle: FxTextStyle.titleSmall(
                                letterSpacing: 0,
                                color: theme.colorScheme.onBackground,
                                fontWeight: 500),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                borderSide: BorderSide.none),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: customTheme.card,
                            prefixIcon: const Icon(
                              MdiIcons.web,
                              size: 22,
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.all(0),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          color: kPrimaryColor,
                          onTap: () async {
                            if (status.text.isEmpty || location.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Please fill all the fields'),
                              ));
                              return;
                            }

                            final cargo = carg;
                            cargo.weight = weight.text;
                            cargo.shippingFee = shippingFee.text;
                            if (status.text == options[0]) {
                              cargo.shipping =
                                  CargoStatus(Timestamp.now(), location.text);
                            } else if (status.text == options[1]) {
                              cargo.inShipment =
                                  CargoStatus(Timestamp.now(), location.text);
                            } else if (status.text == options[2]) {
                              cargo.onDelivery =
                                  CargoStatus(Timestamp.now(), location.text);
                            } else if (status.text == options[3]) {
                              cargo.readyForDelivery =
                                  CargoStatus(Timestamp.now(), location.text);
                            } else if (status.text == options[4]) {
                              cargo.delivered =
                                  CargoStatus(Timestamp.now(), location.text);
                            }
                            setState(() {
                              isLoading = true;
                            });

                            await Provider.of<CargoProvider>(context,
                                    listen: false)
                                .updateTransit(
                              cargo,
                              status.text.toLowerCase(),
                              location.text,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Updated'),
                              ),
                            );

                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pop();
                          },
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                )
                              : FxText.bodyMedium(
                                  'Update',
                                  color: Colors.white,
                                ),
                        ),
                      )
                    ],
                  );
                }),
        ],
      ),
    );
  }

  Widget trackingWidget(String title, String value,
      {bool hasIcon = true, bool isNull = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (hasIcon)
              Icon(Icons.circle,
                  color: isNull ? Colors.grey : kPrimaryColor, size: 10),
            if (hasIcon) const SizedBox(width: 10),
            FxText.bodyMedium(
              title,
              fontWeight: 700,
              color: isNull ? Colors.grey : null,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            if (hasIcon) const SizedBox(width: 20),
            FxText.bodySmall(
              value,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}
