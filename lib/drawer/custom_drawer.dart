import 'package:cargo/constants.dart';
import 'package:cargo/drawer/bottom_user_info.dart';
import 'package:cargo/drawer/custom_list_tile.dart';
import 'package:cargo/drawer/header.dart';
import 'package:cargo/providers/auth_provider.dart';
import 'package:cargo/screens/about_screen.dart';
import 'package:cargo/screens/agent/agent_dashboard.dart';
import 'package:cargo/screens/agent/search_history.dart';
import 'package:cargo/screens/auth/login_screen.dart';
import 'package:cargo/screens/branches/branch_contacts.dart';
import 'package:cargo/screens/branches/branches_screen.dart';
import 'package:cargo/screens/faq_question_screen.dart';
import 'package:cargo/screens/inquiry_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isCollapsed = true;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 500),
        width: _isCollapsed ? 300 : 70,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Color(0xFF130925),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              CustomDrawerHeader(isColapsed: _isCollapsed),
              const Divider(
                color: Colors.grey,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.home_outlined,
                title: 'Home',
                isSelected: index == 0,
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                  Navigator.of(context).pop();
                },
                infoCount: 0,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.location_on_outlined,
                title: 'Branches',
                isSelected: index == 2,
                onTap: () {
                  setState(() {
                    index = 2;
                  });
                  Get.to(() => const BranchesScreen());
                },
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: CupertinoIcons.text_bubble,
                title: 'Enquiries',
                isSelected: index == 3,
                onTap: () {
                  setState(() {
                    index = 3;
                  });
                  Get.to(() => const EnquiryScreen());
                },
                infoCount: 0,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.cloud_outlined,
                title: 'Search history',
                isSelected: index == 4,
                onTap: () {
                  setState(() {
                    index = 4;
                  });
                  Get.to(() => const SearchHistory());
                },
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              const Divider(color: Colors.grey),
              const Spacer(),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.notifications,
                title: 'About Us',
                isSelected: index == 5,
                infoCount: 1,
                onTap: () {
                  setState(() {
                    index = 5;
                  });
                  Get.to(() => const AboutScreen());
                },
              ),
              CustomListTile(
                  isCollapsed: _isCollapsed,
                  icon: Icons.security,
                  title: 'Agent',
                  isSelected: index == 6,
                  infoCount: 0,
                  onTap: () async {
                    setState(() {
                      index = 6;
                    });
                    if (FirebaseAuth.instance.currentUser != null) {
                      final userData =
                          Provider.of<AuthProvider>(context, listen: false);
                      userData.user == null
                          ? await userData.getUser(uid)
                          : null;
                      Get.to(() => const AgentDashboard());
                    } else {
                      Get.to(() => const LogInScreen());
                    }
                  }),
              const SizedBox(height: 10),
              BottomUserInfo(isCollapsed: _isCollapsed),
              Align(
                alignment: _isCollapsed
                    ? Alignment.bottomRight
                    : Alignment.bottomCenter,
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    _isCollapsed
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      _isCollapsed = !_isCollapsed;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
