import 'package:cargo/constants.dart';
import 'package:flutter/material.dart';

class MyBorderWidget extends StatelessWidget {
  const MyBorderWidget({Key? key, this.child}) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: kPrimaryColor, width: 2),
      ),
      child: child,
    );
  }
}
