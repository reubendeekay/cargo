import 'package:cargo/constants.dart';
import 'package:cargo/providers/auth_provider.dart';
import 'package:cargo/providers/cargo_provider.dart';
import 'package:cargo/screens/agent/add_booking.dart';
import 'package:cargo/screens/agent/homepage.dart';
import 'package:cargo/screens/agent/update_shipment_screen.dart';
import 'package:cargo/screens/agent/users/agents_screen.dart';
import 'package:cargo/screens/agent/widgets/directory_screen.dart';
import 'package:cargo/screens/all_shipments.dart';
import 'package:cargo/screens/branches/agent_branches.dart';
import 'package:cargo/screens/notifications/notifications_screen.dart';
import 'package:cargo/screens/tracking/cargo_tracking_screen.dart';
import 'package:cargo/screens/tracking/shipment_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String? trackingNumber;
  @override
  Widget build(BuildContext context) {
    List options = [
      {
        'title': 'Add shipment',
        'onTap': () {
          Get.to(() => const AddBookingScreen());
        },
      },
      {
        'title': 'Update shipment',
        'onTap': () {
          Get.to(() => const UpdateShipmentScreen());
        },
      },
      {
        'title': 'Track shipment',
        'onTap': () {
          Get.to(() => const CargoTrackingScreen(
                isAgent: true,
              ));
        },
      },
      {
        'title': 'Client shipments',
        'onTap': () {
          Get.to(() => const AllShipments(isAdmin: true));
        },
      },
      {
        'title': 'Manage branches',
        'onTap': () {
          Get.to(() => const AgentBranches());
        },
      },
      {
        'title': 'Manage agents',
        'onTap': () {
          Get.to(() => const AgentsManagement());
        },
      },
      {
        'title': 'Push notifications',
        'onTap': () {
          Get.to(() => const NotificationsScreen());
        },
      },
      {
        'title': 'Directory',
        'onTap': () {
          Get.to(() => const CargoDirectory());
        },
      },
      {
        'title': 'Sign out',
        'onTap': () async {
          await FirebaseAuth.instance.signOut();

          Provider.of<AuthProvider>(context, listen: false).setUserNull();
          Get.to(() => const Homepage());
        },
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: FxText.titleMedium(
          'Dashboard',
          fontWeight: 700,
        ),
        centerTitle: true,
        elevation: 00,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            )),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            child: const Icon(
              Icons.person,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        children: [
          TextFormField(
            onChanged: (val) {
              setState(() {
                trackingNumber = val;
              });
            },
            validator: (val) {
              if (val!.isEmpty) {
                return "Please enter a valid tracking number";
              }
              if (val.length < 12) {
                return "Please enter a valid tracking number";
              }
              return null;
            },
            onFieldSubmitted: (val) async {
              if (val.isNotEmpty) {
                try {
                  await Provider.of<CargoProvider>(context, listen: false)
                      .fetchUserCargo(trackingNumber!)
                      .then((value) =>
                          Get.off(() => ShipmentDetails(cargo: value)));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid tracking number')));
                }
              }
            },
            style: FxTextStyle.titleSmall(
                letterSpacing: 0, color: Colors.grey, fontWeight: 500),
            decoration: InputDecoration(
              hintText: "Enter tracking number",
              hintStyle: FxTextStyle.titleSmall(
                  letterSpacing: 0, color: Colors.grey, fontWeight: 500),
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
              fillColor: Colors.grey[100],
              prefixIcon: const Icon(
                MdiIcons.clipboardSearchOutline,
                size: 22,
              ),
              suffixIcon: const Icon(
                MdiIcons.qrcodeScan,
                size: 20,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.search,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                'Next Arrivals',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => const CargoDirectory());
                },
                child: const Text(
                  'See all  >',
                  style: TextStyle(color: kPrimaryColor, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const NextArrivalWidget(),
          const SizedBox(
            height: 40,
          ),
          const Text('Management',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(
            height: 15,
          ),
          ...List.generate(
              options.length,
              (index) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: ListTile(
                      title: Text(
                        options[index]['title'],
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        options[index]['onTap']();
                      },
                      dense: true,
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                  )),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class NextArrivalWidget extends StatelessWidget {
  const NextArrivalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'CHI/KEN/544474',
                style: GoogleFonts.notoSans(
                    fontSize: 16, fontWeight: FontWeight.w700),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Arrives in',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Nairobi,KE',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                height: 40,
                width: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Expected on',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '12/02/2023  | 7am to 10pm',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
