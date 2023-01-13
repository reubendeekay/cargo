// ignore_for_file: library_private_types_in_public_api

import 'package:cargo/constants.dart';
import 'package:cargo/drawer/custom_drawer.dart';
import 'package:cargo/providers/branch_provider.dart';
import 'package:cargo/providers/cargo_provider.dart';
import 'package:cargo/providers/location_provider.dart';
import 'package:cargo/screens/agent/service_card.dart';
import 'package:cargo/screens/agent/user_notifications.dart';
import 'package:cargo/screens/branches/branches_screen.dart';
import 'package:cargo/screens/faq_question_screen.dart';
import 'package:cargo/models/notification_model.dart';
import 'package:cargo/screens/tracking/verification_dialog.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:cargo/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Provider.of<CargoProvider>(context, listen: false).initialiseTwillio();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leadingWidth: 70,
        leading: Builder(
          builder: (context) => Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: FxText.titleMedium('Fastgate Cargo'.toUpperCase(),
            color: Colors.white, fontWeight: 700),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const UserNotifications());
            },
            icon: const Icon(Icons.notifications_on_sharp, color: Colors.white),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Container(
        color: theme.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40)),
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
                            scale: 1,
                            child: Opacity(
                                opacity: 0.5,
                                child: Lottie.asset('assets/spin.json'))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          FxText.titleLarge(
                            'Track your shipment',
                            fontWeight: 700,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FxText.titleSmall(
                            'Please enter your tracking number',
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
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
                                    style: GoogleFonts.ibmPlexSans(),
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Enter tracking number',
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.assistant_navigation,
                                        color: Colors.red.withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: isLoading
                                    ? null
                                    : () async {
                                        if (formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          try {
                                            await Provider.of<CargoProvider>(
                                                    context,
                                                    listen: false)
                                                .getShipment(trackingNumber!);
                                            setState(() {
                                              isLoading = false;
                                            });
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
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        }
                                      },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                            color: kPrimaryColor,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.search,
                                          color: kPrimaryColor,
                                        ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: FxText.bodyLarge(
                  "SERVICES",
                  fontWeight: 800,
                  letterSpacing: 0.3,
                  fontSize: 18,
                )),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  ServiceCard(
                    title: 'Freight',
                    description: 'Air/Sea freight',
                    image: 'call.png',
                    onTap: () async {
                      await launchUrl(Uri.parse(
                          'https://fastgatecargo.com/?services=ocean-freight'));
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ServiceCard(
                    image: 'truck.png',
                    onTap: () async {
                      await Provider.of<BranchProvider>(context, listen: false)
                          .getBranches();
                      Get.to(() => const BranchesScreen());
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ServiceCard(
                    title: 'FAQ',
                    description: 'Frequent questions',
                    image: 'faq.png',
                    onTap: () {
                      Get.to(() => const FAQQuestionScreen());
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ServiceCard(
                    title: 'About',
                    description: 'About Us',
                    image: 'about.png',
                    onTap: () async {
                      await launchUrl(
                          Uri.parse('https://fastgatecargo.com/?page_id=1563'));
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
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
                Icon(
                  Icons.my_location_sharp,
                  size: 14,
                  color: Colors.grey[300],
                ),
                const SizedBox(
                  width: 5,
                ),
                FxText.bodySmall('Nairobi, KE',
                    color: Colors.grey[300], fontWeight: 600),
              ],
            );
          }
          final location = Provider.of<LocationProvider>(context, listen: false)
              .userLocation;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.my_location_sharp,
                size: 14,
                color: Colors.grey[300],
              ),
              const SizedBox(
                width: 5,
              ),
              FxText.bodySmall('${location!.city!}, ${location.country!}',
                  color: Colors.grey[300], fontWeight: 600),
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
                  FxText.bodySmall('By ${not.createdBy!}', fontWeight: 500),
              state: StepState.indexed,
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FxText.bodySmall(" - ${not.message!}",
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
