import 'package:cargo/models/cargo_model.dart';
import 'package:cargo/providers/auth_provider.dart';
import 'package:cargo/providers/cargo_provider.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:cargo/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class AddBookingScreen extends StatefulWidget {
  const AddBookingScreen({Key? key}) : super(key: key);

  @override
  _AddBookingScreenState createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  String? invoiceNumber;

  String? origin;

  String? destinaton;
  String? phoneNumber;

  String? paymentMode;

  String? customerName;
  String? deliveryDate;

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
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: theme.colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
        title: FxText.titleMedium("Add Shipment", fontWeight: 600),
      ),
      body: ListView(
        padding: FxSpacing.nTop(20),
        children: <Widget>[
          FxText.bodyLarge("Personal information",
              fontWeight: 600, letterSpacing: 0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      customerName = val;
                    });
                  },
                  style: FxTextStyle.titleSmall(
                      letterSpacing: 0,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 500),
                  decoration: InputDecoration(
                    hintText: "Customer Name",
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
                      MdiIcons.account,
                      size: 22,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.all(0),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      phoneNumber = val;
                    });
                  },
                  style: FxTextStyle.titleSmall(
                      letterSpacing: 0,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 500),
                  decoration: InputDecoration(
                    hintText: "Phone Number",
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
                      MdiIcons.phoneOutline,
                      size: 22,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.all(0),
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24, bottom: 0),
                child: FxText.bodyLarge("Cargo information",
                    fontWeight: 600, letterSpacing: 0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          invoiceNumber = val;
                        });
                      },
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        hintText: "Invoice Number",
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
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          origin = val;
                        });
                      },
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        hintText: "Cargo Origin",
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
                          MdiIcons.globeLight,
                          size: 22,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(0),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          destinaton = val;
                        });
                      },
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        hintText: "Cargo Destination",
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
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: FxText.bodyLarge("Other information",
                    fontWeight: 600, letterSpacing: 0),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      deliveryDate = val;
                    });
                  },
                  style: FxTextStyle.titleSmall(
                      letterSpacing: 0,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 500),
                  decoration: InputDecoration(
                    hintText: "Delivery Date",
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
                    prefixIcon: const Icon(MdiIcons.timer),
                    isDense: true,
                    contentPadding: const EdgeInsets.all(0),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      paymentMode = val;
                    });
                  },
                  style: FxTextStyle.titleSmall(
                      letterSpacing: 0,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 500),
                  decoration: InputDecoration(
                    hintText: " Payment Method",
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
                    prefixIcon: const Icon(MdiIcons.creditCardOutline),
                    isDense: true,
                    contentPadding: const EdgeInsets.all(0),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withAlpha(28),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        final cargo = CargoModel(
                          createdAt: DateTime.now().toString(),
                          customerName: customerName,
                          currentLocation: origin,
                          docNo: origin![0] +
                              origin![1] +
                              origin![2] +
                              '/' +
                              destinaton![0] +
                              destinaton![1] +
                              destinaton![2] +
                              '/' +
                              invoiceNumber!,
                          userId: uid,
                          destination: destinaton,
                          phoneNumber: phoneNumber,
                          invoiceNumber: invoiceNumber,
                          origin: origin,
                          paymentMode: paymentMode,
                          deliveryDate: deliveryDate,
                        );

                        await Provider.of<CargoProvider>(context, listen: false)
                            .addCargo(cargo);
                        Navigator.of(context).pop();

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Shipping details added to database'),
                        ));
                      },
                      child: FxText.bodyMedium("Add Shipment",
                          fontWeight: 600, color: theme.colorScheme.onPrimary),
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(FxSpacing.xy(16, 0))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
