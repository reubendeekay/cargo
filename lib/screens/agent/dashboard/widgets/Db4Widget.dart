import 'package:cargo/screens/agent/dashboard/widgets/DbColors.dart';
import 'package:flutter/material.dart';

import 'DbConstant.dart';

Widget text(var text,
    {var fontSize = textSizeLargeMedium,
    textColor = db4_textColorSecondary,
    var fontFamily = fontRegular,
    var isCentered = false,
    var maxLine = 1,
    var latterSpacing = 0.25}) {
  return Text(text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: maxLine,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: double.parse(fontSize.toString()),
          color: textColor,
          height: 1.5,
          letterSpacing: latterSpacing));
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color bgColor = db4_white,
    var showShadow = false}) {
  return BoxDecoration(
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      color: bgColor,
      boxShadow: showShadow
          ? const [
              BoxShadow(color: dbShadowColor, blurRadius: 10, spreadRadius: 2)
            ]
          : [const BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}
