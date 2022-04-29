import 'package:cargo/screens/agent/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    navigationPage();
  }

  void navigationPage() async {
    await Future.delayed(const Duration(milliseconds: 5000));
    Get.off(() => const Homepage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Lottie.asset('assets/splash.json',
            repeat: false, fit: BoxFit.cover),
      ),
    );
  }
}
