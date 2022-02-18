import 'package:cargo/constants.dart';
import 'package:cargo/screens/agent/agent_login.dart';
import 'package:cargo/screens/home/auth_screen.dart';
import 'package:cargo/screens/home/homepage.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyNav extends StatelessWidget {
  const MyNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavBar(
      actionButton: CurvedActionBar(
          onTab: (value) {
            /// perform action here
            launch('https://wa.me/254723266163');
          },
          activeIcon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: const Icon(
              FontAwesomeIcons.telegram,
              size: 50,
              color: kPrimaryColor,
            ),
          ),
          inActiveIcon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: Colors.white70, shape: BoxShape.circle),
            child: const Icon(
              FontAwesomeIcons.telegram,
              size: 50,
              color: kPrimaryColor,
            ),
          ),
          text: ""),
      activeColor: kSecondaryColor,
      navBarBackgroundColor: kPrimaryColor,
      inActiveColor: Colors.white,
      appBarItems: [
        FABBottomAppBarItem(
            activeIcon: const Icon(
              Icons.home,
              color: kSecondaryColor,
            ),
            inActiveIcon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            text: 'Home'),
        FABBottomAppBarItem(
            activeIcon: const Icon(
              Icons.security,
              color: kSecondaryColor,
            ),
            inActiveIcon: const Icon(
              Icons.security,
              color: Colors.white,
            ),
            text: 'Admin'),
      ],
      bodyItems: const [
        Homepage(),
        AgentLogin(),
      ],
      actionBarView: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.orange,
      ),
    );
  }
}
