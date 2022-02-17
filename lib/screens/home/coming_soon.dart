import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/soon.json'),
      ),
    );
  }
}
