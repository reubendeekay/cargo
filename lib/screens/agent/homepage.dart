import 'package:cargo/screens/faq_question_screen.dart';
import 'package:cargo/models/notification_model.dart';
import 'package:cargo/screens/auth/login_screen.dart';
import 'package:cargo/screens/tracking/cargo_tracking_screen.dart';
import 'package:cargo/providers/auth_provider.dart';
import 'package:cargo/screens/agent/dashboard/agent_dashboard.dart';
import 'package:cargo/screens/branches/branch_contacts.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:cargo/theme/custom_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 6000)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                width: double.infinity,
                color: const Color(0xff1529e8),
                child: Lottie.asset(
                  'assets/splash2.json',
                  repeat: false,
                ),
              ),
            );
          }
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: FxText.titleMedium("Fastgate Cargo Services",
                    fontWeight: 600),
              ),
              body: Container(
                  color: theme.backgroundColor,
                  child: ListView(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: FxText.bodySmall("SERVICES",
                              fontWeight: 600, letterSpacing: 0.3)),
                      GridView.count(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          crossAxisCount: 2,
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          mainAxisSpacing: 20,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                          children: <Widget>[
                            HomepageCard(
                              subtitle: 'Track your shipment',
                              subject: 'TRACKING',
                              backgroundColor: Colors.blue,
                              onTap: () {
                                Get.to(() => const CargoTrackingScreen());
                              },
                            ),
                            HomepageCard(
                              subtitle: 'Talk to our experts',
                              subject: 'Branches',
                              backgroundColor: Colors.red,
                              onTap: () {
                                Get.to(() => const BranchContactsScreen());
                              },
                            ),
                            HomepageCard(
                              subtitle: 'Access the admin panel',
                              subject: 'Admin',
                              onTap: () async {
                                if (FirebaseAuth.instance.currentUser != null) {
                                  final userData = Provider.of<AuthProvider>(
                                      context,
                                      listen: false);
                                  userData.user == null
                                      ? await userData.getUser(uid)
                                      : null;
                                  Get.to(() => const AgentDashboard());
                                } else {
                                  Get.to(() => const LogInScreen());
                                }
                              },
                              backgroundColor: Colors.green,
                            ),
                            HomepageCard(
                              subtitle: 'Know about us',
                              subject: 'FAQ',
                              onTap: () {
                                Get.to(() => const FAQQuestionScreen());
                              },
                              backgroundColor: Colors.orange,
                            ),
                          ]),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: FxText.bodySmall("NEWS",
                            fontWeight: 600, letterSpacing: 0.3),
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('notifications')
                              .orderBy('createdAt', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: FxText.titleMedium(
                                  'Error: ${snapshot.error}',
                                  color: Colors.red,
                                ),
                              );
                            }

                            if (!snapshot.hasData) {
                              return Center(
                                child: FxText.titleMedium(
                                  'No Notifications yet',
                                  color: Colors.grey,
                                ),
                              );
                            }
                            List<DocumentSnapshot> docs = snapshot.data!.docs;
                            if (docs.isEmpty) {
                              return Center(
                                child: FxText.titleMedium(
                                  'No Notifications yet',
                                  color: Colors.grey,
                                ),
                              );
                            }

                            return NewsWidget(
                              nots: docs
                                  .map((e) => NotificationModel.fromJson(e))
                                  .toList(),
                            );
                          })
                    ],
                  )));
        });
  }
}

class HomepageCard extends StatelessWidget {
  final Color backgroundColor;
  final String subject;
  final String subtitle;
  final Function? onTap;

  const HomepageCard(
      {Key? key,
      required this.backgroundColor,
      this.onTap,
      required this.subject,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: FxContainer.none(
        borderRadiusAll: 4,
        color: backgroundColor,
        height: 125,
        child: Container(
          padding: const EdgeInsets.only(bottom: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FxText.titleMedium(subject, fontWeight: 600, color: Colors.white),
              FxText.bodySmall(subtitle,
                  fontWeight: 500, color: Colors.white, letterSpacing: 0),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsWidget extends StatefulWidget {
  const NewsWidget({Key? key, required this.nots}) : super(key: key);
  final List<NotificationModel> nots;

  @override
  _NewsWidgetState createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  int _currentStep = 0;
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Stepper(
      physics: const ClampingScrollPhysics(),
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return _buildControlBuilder(_currentStep);
      },
      currentStep: _currentStep,
      onStepTapped: (pos) {
        setState(() {
          _currentStep = pos;
        });
      },
      steps: widget.nots
          .map(
            (not) => Step(
              isActive: true,
              title: FxText.bodyLarge(not.category!, fontWeight: 600),
              subtitle:
                  FxText.bodySmall('By ' + not.createdBy!, fontWeight: 500),
              state: StepState.indexed,
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FxText.bodySmall(" - " + not.message!,
                    color: theme.colorScheme.onBackground),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildControlBuilder(int position) {
    return Container();
  }
}
