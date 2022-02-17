import 'package:flutter/material.dart';

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
    Future.delayed(Duration.zero, () async {
      await startAnimation();
    });
  }

  Future<void> startAnimation() async {
    for (int i = 0; i < 25; i++) {
      await Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          heigth = heigth * 4;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: CircleAvatar(
            radius: heigth,
            backgroundColor: Colors.white,
            backgroundImage: const NetworkImage(
              'https://images.unsplash.com/photo-1613690399151-65ea69478674?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80',
            ),
          )),
        ],
      ),
    );
  }
}
