import 'package:cargo/screens/agent/rate_request_details.dart';
import 'package:cargo/widgets/logo.dart';
import 'package:cargo/widgets/my_border_widget.dart';
import 'package:cargo/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

class RateRequest extends StatelessWidget {
  const RateRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: const [
              Icon(
                FontAwesomeIcons.truck,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Rate Request'),
            ],
          ),
        ),
        body: Column(
          children: [
            const Center(
              child: Logo(),
            ),
            SizedBox(
              height: size.height * .4,
              child: MyBorderWidget(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PrimaryButton(
                      buttonText: 'Sea Rate Request',
                      icon: FontAwesomeIcons.ship,
                      onPressed: () {
                        Get.to(() => const RateRequestDetails(
                            appBarTitle: 'Sea Rate Request'));
                      },
                    ),
                    PrimaryButton(
                      buttonText: 'Air Rate Request',
                      icon: FontAwesomeIcons.plane,
                      onPressed: () {
                        Get.to(() => const RateRequestDetails(
                            appBarTitle: 'Air Rate Request'));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
