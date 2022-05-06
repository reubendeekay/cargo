import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawerHeader extends StatelessWidget {
  final bool isColapsed;

  const CustomDrawerHeader({
    Key? key,
    required this.isColapsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 65,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40, child: Image.asset('assets/images/logo.png')),
          if (isColapsed) const SizedBox(width: 5),
          if (isColapsed)
            SizedBox(
              height: 30,
              child: Image.asset('assets/images/splash.png'),
            ),
        ],
      ),
    );
  }
}
