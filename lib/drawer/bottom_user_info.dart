import 'package:cargo/helpers/cached_image.dart';
import 'package:cargo/providers/auth_provider.dart';
import 'package:cargo/screens/agent/agent_dashboard.dart';
import 'package:cargo/screens/agent/homepage.dart';
import 'package:cargo/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class BottomUserInfo extends StatefulWidget {
  final bool isCollapsed;

  const BottomUserInfo({
    Key? key,
    required this.isCollapsed,
  }) : super(key: key);

  @override
  State<BottomUserInfo> createState() => _BottomUserInfoState();
}

class _BottomUserInfoState extends State<BottomUserInfo> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(
      context,
    ).user;
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser != null
            ? Provider.of<AuthProvider>(context).getUser(uid)
            : null,
        builder: (context, snapshot) {
          return InkWell(
            onTap: () async {
              if (FirebaseAuth.instance.currentUser != null) {
                final userData =
                    Provider.of<AuthProvider>(context, listen: false);
                userData.user == null ? await userData.getUser(uid) : null;
                Get.to(() => const AgentDashboard());
              } else {
                Get.to(() => const LogInScreen());
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: widget.isCollapsed ? 70 : 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(20),
              ),
              child: widget.isCollapsed
                  ? Center(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: cachedImage(
                                  user != null
                                      ? user.profilePic!
                                      : 'https://t3.ftcdn.net/jpg/02/99/21/98/360_F_299219888_2E7GbJyosu0UwAzSGrpIxS0BrmnTCdo4.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      user == null ? 'Guest' : user.fullName!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    user == null
                                        ? 'User'
                                        : user.role!.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: IconButton(
                                onPressed: () async {
                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    await FirebaseAuth.instance.signOut();
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setUserNull();

                                    Get.offAll(() => const Homepage());
                                  }
                                },
                                icon: const Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: cachedImage(
                                user != null
                                    ? user.profilePic!
                                    : 'https://t3.ftcdn.net/jpg/02/99/21/98/360_F_299219888_2E7GbJyosu0UwAzSGrpIxS0BrmnTCdo4.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () async {
                              if (FirebaseAuth.instance.currentUser != null) {
                                await FirebaseAuth.instance.signOut();
                              }
                            },
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        });
  }
}
