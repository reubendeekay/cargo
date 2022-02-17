import 'package:cargo/helpers/lists.dart';
import 'package:cargo/screens/shipment/shipment_details.dart';
import 'package:cargo/widgets/logo.dart';
import 'package:cargo/widgets/my_border_widget.dart';
import 'package:cargo/widgets/my_dropdown.dart';
import 'package:cargo/widgets/my_text_field.dart';
import 'package:cargo/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class UserTrackingScreen extends StatefulWidget {
  const UserTrackingScreen({Key? key}) : super(key: key);

  @override
  State<UserTrackingScreen> createState() => _UserTrackingScreenState();
}

class _UserTrackingScreenState extends State<UserTrackingScreen> {
  String? type;
  String? trackingNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(
              Icons.bubble_chart,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Tracking",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Logo(),
          MyBorderWidget(
            child: Column(
              children: [
                MyDropDown(
                  hintText: 'Select type',
                  selectedOption: (val) {
                    setState(() {
                      type = val;
                    });
                  },
                  options: exportTypes,
                ),
                const SizedBox(
                  height: 20,
                ),
                myTextField(
                    hint: 'Tracking number',
                    onChanged: (val) {
                      setState(() {
                        trackingNumber = val;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  buttonText: 'Search',
                  onPressed: () {
                    Get.to(() => const ShipmentDetails());
                  },
                  hintText: 'Track your Cargo',
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
