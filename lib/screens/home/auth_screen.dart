import 'package:cargo/constants.dart';
import 'package:cargo/screens/agent/agent_login.dart';
import 'package:cargo/screens/home/coming_soon.dart';
import 'package:cargo/screens/tracking/user_tracking_screen.dart';
import 'package:cargo/widgets/logo.dart';
import 'package:cargo/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 20,
          ),
          const Logo(),
          Container(
            padding: const EdgeInsets.all(20),
            height: size.height * .5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kPrimaryColor, width: 2),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryButton(
                    onPressed: () {
                      Get.to(() => const UserTrackingScreen());
                    },
                    buttonText: 'Track & Trace',
                    hintText: 'Track your Cargo'),
                PrimaryButton(
                  onPressed: () {
                    Get.to(() => const ComingSoonScreen());
                  },
                  buttonText: 'Voice Track & Trace',
                  hintText: 'Track your Cargo by voice',
                ),
                PrimaryButton(
                    onPressed: () {
                      Get.to(() => const AgentLogin());
                    },
                    buttonText: 'Agent Login',
                    hintText: 'Booking/Rate Request/ Track your Cargo/ Alerts',
                    color: kPrimaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
