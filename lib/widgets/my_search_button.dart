import 'package:cargo/constants.dart';
import 'package:flutter/material.dart';

class MySearchButton extends StatelessWidget {
  const MySearchButton({Key? key, this.onPressed}) : super(key: key);
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed,
      child: Container(
        height: 40,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kPrimaryColor,
        ),
        child: const Center(child: Icon(Icons.search, color: Colors.white)),
      ),
    );
  }
}
