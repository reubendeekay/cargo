import 'package:cargo/constants.dart';
import 'package:cargo/screens/home/branch_contacts.dart';
import 'package:cargo/screens/home/coming_soon.dart';
import 'package:cargo/screens/notifications/notifications_screen.dart';
import 'package:cargo/screens/tracking/user_tracking_screen.dart';
import 'package:cargo/widgets/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const TopHomeWidget(),
        const TopHomeImage(),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.count(
              padding: EdgeInsets.zero,
              childAspectRatio: 1.4,
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              children: List.generate(
                  4,
                  (i) => GestureDetector(
                        onTap: () => homeOptions[i]['page'](),
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  homeOptions[i]['icon'],
                                  color: Colors.white.withOpacity(0.15),
                                  size: 90,
                                ),
                              ),
                              Center(
                                child: Row(children: [
                                  Expanded(
                                    child: Text(
                                      homeOptions[i]['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  )
                                ]),
                              ),
                            ],
                          ),
                        ),
                      )),
            ),
          ),
        ),
      ],
    ));
  }
}

class TopHomeWidget extends StatelessWidget {
  const TopHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      color: kPrimaryColor,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Row(children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: kSecondaryColor,
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(
              width: 5,
            ),
            const Expanded(
              child: Text(
                'FASTGATE CARGO\n SERVICES',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ]),
        ],
      ),
    );
  }
}

class TopHomeImage extends StatelessWidget {
  const TopHomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      child: AspectRatio(
        aspectRatio: 19 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Hero(
            tag: 'logo',
            child: Image.network(
              'https://images.unsplash.com/photo-1613690399151-65ea69478674?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> homeOptions = [
  {
    'title': 'Track your Shipment',
    'icon': FontAwesomeIcons.globeAfrica,
    'page': () => Get.to(() => const UserTrackingScreen()),
  },
  {
    'title': 'About Us',
    'icon': FontAwesomeIcons.info,
    'page': () => Get.to(() => MyPdfViewer()),
  },
  {
    'title': 'Notifications',
    'icon': Icons.notifications,
    'page': () => Get.to(() => const NotificationsScreen()),
  },
  {
    'title': 'Branch Contacts',
    'icon': FontAwesomeIcons.codeBranch,
    'page': () => Get.to(() => const BranchContactsScreen()),
  },
];
