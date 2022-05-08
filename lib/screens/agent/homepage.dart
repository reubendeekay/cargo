import 'package:cargo/constants.dart';
import 'package:cargo/drawer/custom_drawer.dart';
import 'package:cargo/providers/branch_provider.dart';
import 'package:cargo/providers/cargo_provider.dart';
import 'package:cargo/providers/location_provider.dart';
import 'package:cargo/screens/about_screen.dart';
import 'package:cargo/screens/agent/service_card.dart';
import 'package:cargo/screens/agent/services_screen.dart';
import 'package:cargo/screens/agent/user_notifications.dart';
import 'package:cargo/screens/branches/branches_screen.dart';
import 'package:cargo/screens/faq_question_screen.dart';
import 'package:cargo/models/notification_model.dart';
import 'package:cargo/screens/auth/login_screen.dart';
import 'package:cargo/screens/tracking/cargo_tracking_screen.dart';
import 'package:cargo/providers/auth_provider.dart';
import 'package:cargo/screens/agent/dashboard/agent_dashboard.dart';
import 'package:cargo/screens/branches/branch_contacts.dart';
import 'package:cargo/screens/tracking/verification_dialog.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:cargo/theme/custom_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late CustomTheme customTheme;
  late ThemeData theme;
  String? trackingNumber;
  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  final formKey = GlobalKey<FormState>();
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller,
        elevation: 0,
        centerTitle: true,
        title: FxText.titleSmall('Current location',
            color: Colors.grey, fontWeight: 600),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const UserNotifications());
            },
            icon: const Icon(
              Icons.notifications_on_sharp,
              color: Colors.red,
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Container(
        color: theme.backgroundColor,
        child: ListView(
          controller: controller,
          children: <Widget>[
            const LocationWidget(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: kPrimaryColor,
              ),
              height: size.height * 0.5,
              width: size.width,
              child: Form(
                key: formKey,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SizedBox(
                        height: size.height * 0.35,
                        child: Transform.scale(
                            scale: 1.24,
                            child: Opacity(
                                opacity: 0.3,
                                child: Lottie.asset('assets/track.json'))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          FxText.titleLarge(
                            'Track your shipment',
                            fontWeight: 700,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          FxText.titleSmall(
                            'Please enter your tracking number',
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  trackingNumber = val;
                                });
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please enter tracking number';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.search,
                              onFieldSubmitted: (val) async {
                                if (formKey.currentState!.validate()) {
                                  try {
                                    await Provider.of<CargoProvider>(context,
                                            listen: false)
                                        .getShipment(val);
                                    showDialog(
                                        context: context,
                                        builder: (ctx) =>
                                            const VerificationDialog());
                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Something went wrong"),
                                    ));
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter tracking number',
                                  hintStyle: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.track_changes_rounded,
                                    color: Colors.red.withOpacity(0.8),
                                  ),
                                  suffixIcon: InkWell(
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          try {
                                            await Provider.of<CargoProvider>(
                                                    context,
                                                    listen: false)
                                                .getShipment(trackingNumber!);
                                            showDialog(
                                                context: context,
                                                builder: (ctx) =>
                                                    const VerificationDialog());
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Something went wrong"),
                                            ));
                                          }
                                        }
                                      },
                                      child: const Icon(Icons.search,
                                          color: kPrimaryColor))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: FxText.bodyMedium("SERVICES",
                    fontWeight: 600, letterSpacing: 0.3)),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              mainAxisSpacing: 20,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              children: <Widget>[
                ServiceCard(
                  title: 'Freight',
                  description: 'Air/Sea freight',
                  image: 'call.png',
                  onTap: () {
                    Get.to(() => const ServicesScreen());
                  },
                ),
                ServiceCard(
                  image: 'truck.png',
                  onTap: () async {
                    await Provider.of<BranchProvider>(context, listen: false)
                        .getBranches();
                    Get.to(() => const BranchesScreen());
                  },
                ),
                ServiceCard(
                  title: 'FAQ',
                  description: 'Frequent questions',
                  image: 'faq.png',
                  onTap: () {
                    Get.to(() => const FAQQuestionScreen());
                  },
                ),
                ServiceCard(
                  title: 'About',
                  description: 'About Us',
                  image: 'about.png',
                  onTap: () {
                    Get.to(() => const AboutScreen());
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<LocationProvider>(context, listen: false)
            .getCurrentLocation(),
        builder: (ctx, snapsot) {
          if (snapsot.connectionState == ConnectionState.waiting) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.my_location_sharp,
                  size: 14,
                ),
                const SizedBox(
                  width: 5,
                ),
                FxText.titleMedium('Nairobi, KE',
                    color: Colors.black, fontWeight: 600),
              ],
            );
          }
          final location = Provider.of<LocationProvider>(context, listen: false)
              .userLocation;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.my_location_sharp,
                size: 14,
              ),
              const SizedBox(
                width: 5,
              ),
              FxText.titleMedium(location!.city! + ', ' + location.country!,
                  color: Colors.black, fontWeight: 600),
            ],
          );
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
              isActive: _currentStep == widget.nots.indexOf(not),
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
