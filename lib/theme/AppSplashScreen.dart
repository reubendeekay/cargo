import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cargo/constants.dart';
import 'package:cargo/providers/cargo_provider.dart';
import 'package:cargo/providers/location_provider.dart';
import 'package:cargo/screens/agent/homepage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<LocationProvider>(context, listen: false)
          .getCurrentLocation();
      setOpacity();
    });
  }

  bool isVisible = false;
  void setOpacity() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        AnimatedSplashScreen(
          backgroundColor: kPrimaryColor,
          splash: 'assets/images/logo.png',
          duration: 3000,
          centered: true,
          nextScreen: const Homepage(),
          splashTransition: SplashTransition.rotationTransition,
          pageTransitionType: PageTransitionType.fade,
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: size.height * 0.35,
            child: AnimatedOpacity(
              opacity: isVisible ? 1 : 0,
              duration: const Duration(milliseconds: 1000),
              child: Center(
                child: SizedBox(
                    child: Image.asset('assets/images/splash.png'), height: 50),
              ),
            ),
            top: 0),
      ],
    );
  }
}
