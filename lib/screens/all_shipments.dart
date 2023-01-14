import 'package:cargo/constants.dart';
import 'package:cargo/helpers/my_loader.dart';
import 'package:cargo/models/cargo_model.dart';
import 'package:cargo/providers/cargo_provider.dart';
import 'package:cargo/screens/tracking/shipment_details.dart';
import 'package:cargo/screens/tracking/verification_dialog.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:cargo/theme/custom_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/route_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class AllShipments extends StatefulWidget {
  const AllShipments({Key? key, this.isAdmin = false}) : super(key: key);
  final bool isAdmin;

  @override
  State<AllShipments> createState() => _AllShipmentsState();
}

class _AllShipmentsState extends State<AllShipments> {
  late CustomTheme customTheme;
  late ThemeData theme;
  String? phoneNumber;
  bool isTrue = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
          ),
          title: FxText.titleMedium("Shipments", fontWeight: 600),
          actions: const [
            Icon(Icons.filter_list),
            SizedBox(
              width: 15,
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          phoneNumber = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter a phone number";
                        }
                        if (val.length < 12) {
                          return "Please enter a valid phone number";
                        }
                        return null;
                      },
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        hintText: "Enter your phone number",
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
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          MdiIcons.account,
                          size: 22,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(0),
                      ),
                      keyboardType: TextInputType.phone,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (widget.isAdmin) {
                        setState(() {
                          isTrue = true;
                          isLoading = false;
                        });
                        return;
                      }
                      await Provider.of<CargoProvider>(context, listen: false)
                          .sendOtp(phoneNumber!);
                      setState(() {
                        isLoading = false;
                      });
                      showDialog(
                          context: context,
                          builder: (ctx) => VerificationDialog(
                                onVerify: (val) {
                                  setState(() {
                                    isTrue = val;
                                  });
                                },
                              ));
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      child: isLoading
                          ? const Center(
                              child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      color: kPrimaryColor)),
                            )
                          : const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            if (isTrue)
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('cargos')
                        .where('phoneNumber', isEqualTo: phoneNumber)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: MyLoader(
                            color: kPrimaryColor,
                          ),
                        );
                      }
                      List<DocumentSnapshot> docs = snapshot.data!.docs;

                      return ListView(
                          children: docs
                              .map((doc) => ShipmentTile(
                                    cargo: CargoModel.fromJson(doc),
                                  ))
                              .toList());
                    }),
              ),
          ],
        ));
  }
}

class ShipmentTile extends StatelessWidget {
  const ShipmentTile({Key? key, required this.cargo}) : super(key: key);
  final CargoModel cargo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ShipmentDetails(cargo: cargo));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 2, left: 2, right: 2),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4)),
              child: const Icon(
                MdiIcons.package,
                color: kPrimaryColor,
                size: 14,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status(cargo),
                    style: TextStyle(
                        color: status(cargo) == 'Delivered'
                            ? Colors.red
                            : kPrimaryColor,
                        fontSize: 12),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        cargo.docNo!.replaceAll('_', '/').toUpperCase(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        cargo.origin!,
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('------->'),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        cargo.destination!,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String status(CargoModel cargo) {
  if (cargo.delivered != null) {
    return 'Delivered';
  }

  if (cargo.readyForDelivery != null) {
    return 'Arrived at ${cargo.readyForDelivery!.location}';
  }
  if (cargo.inShipment != null) {
    return 'Shipment is on its way';
  }

  if (cargo.shipping != null) {
    return 'Shipment has been loaded';
  }
  return 'Shipment has been received';
}
