import 'package:cargo/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      this.buttonText,
      this.color,
      this.hintText,
      this.onPressed,
      this.icon})
      : super(key: key);
  final String? buttonText;
  final String? hintText;
  final Color? color;
  final IconData? icon;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: double.infinity,
          child: RaisedButton(
            onPressed: () {
              onPressed!();
            },
            color: color ?? kPrimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon ?? Icons.search,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Text(
                  buttonText!,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        if (hintText != null)
          Text(
            hintText!,
            style: const TextStyle(color: Colors.black, fontSize: 13),
          ),
      ],
    );
  }
}
