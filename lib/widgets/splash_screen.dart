import 'package:cargo/bottom_nav_bar.dart';

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
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isInit = true;
      });
    });

    Future.delayed(const Duration(seconds: 8), () async {
      await Get.off(() => const MyNav());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: size.height,
              width: size.width,
              color: const Color.fromRGBO(255, 255, 255, 1),
              child: Hero(
                tag: 'logo',
                child: Image.network(
                  'https://images.unsplash.com/photo-1613690399151-65ea69478674?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80',
                  fit: BoxFit.cover,
                ),
              )),
          Center(
            child: AnimatedOpacity(
              opacity: isInit ? 1 : 0,
              duration: const Duration(milliseconds: 1200),
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(255, 248, 252, 6),
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
