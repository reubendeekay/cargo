import 'package:cargo/screens/agent/dashboard.dart';
import 'package:cargo/screens/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isInit = false;
  double heigth = 50;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      await Get.to(() => const Homepage());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
          ),
          Container(
              height: heigth,
              width: size.width,
              color: const Color.fromRGBO(255, 255, 255, 1),
              child: Image.network(
                'https://images.unsplash.com/photo-1613690399151-65ea69478674?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80',
                fit: BoxFit.cover,
              ))
        ],
      ),
    );
  }
}
