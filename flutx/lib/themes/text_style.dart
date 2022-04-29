// ignore_for_file: deprecated_member_use_from_same_package

/*
* File : App Theme
* Version : 1.0.0
* */

// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// [FxTextStyle] - gives 13 different type of styles to the text on the basis of size
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

enum FxTextType {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,

  @Deprecated('use')
  h4,
  @Deprecated('use')
  h5,
  @Deprecated('use')
  h6,
  @Deprecated('use')
  sh1,
  @Deprecated('use')
  sh2,
  @Deprecated('use')
  button,
  @Deprecated('use')
  caption,
  @Deprecated('use')
  overline,

// Material Design 3
  @Deprecated('use')
  d1,
  @Deprecated('use')
  d2,
  @Deprecated('use')
  d3,
  @Deprecated('use')
  h1,
  @Deprecated('use')
  h2,
  @Deprecated('use')
  h3,
  @Deprecated('use')
  t1,
  @Deprecated('use')
  t2,
  @Deprecated('use')
  t3,
  @Deprecated('use')
  l1,
  @Deprecated('use')
  l2,
  @Deprecated('use')
  l3,
  @Deprecated('use')
  b1,
  @Deprecated('use')
  b2,
  @Deprecated('use')
  b3
}

class FxTextStyle {
  static Function _fontFamily = GoogleFonts.ibmPlexSans;

  static Map<int, FontWeight> _defaultFontWeight = {
    100: FontWeight.w100,
    200: FontWeight.w200,
    300: FontWeight.w300,
    400: FontWeight.w300,
    500: FontWeight.w400,
    600: FontWeight.w500,
    700: FontWeight.w600,
    800: FontWeight.w700,
    900: FontWeight.w800,
  };

  static Map<FxTextType, double> _defaultTextSize = {
    // Material Design 3

    FxTextType.displayLarge: 57,
    FxTextType.displayMedium: 45,
    FxTextType.displaySmall: 36,

    FxTextType.headlineLarge: 32,
    FxTextType.headlineMedium: 28,
    FxTextType.headlineSmall: 26,

    FxTextType.titleLarge: 22,
    FxTextType.titleMedium: 16,
    FxTextType.titleSmall: 14,

    FxTextType.labelLarge: 14,
    FxTextType.labelMedium: 12,
    FxTextType.labelSmall: 11,

    FxTextType.bodyLarge: 16,
    FxTextType.bodyMedium: 14,
    FxTextType.bodySmall: 12,

    // @Deprecated('')
    FxTextType.h4: 36,
    FxTextType.h5: 25,
    FxTextType.h6: 21,
    FxTextType.sh1: 17,
    FxTextType.sh2: 15,
    FxTextType.button: 13,
    FxTextType.caption: 12,
    FxTextType.overline: 10,

    // Material Design 3

    FxTextType.d1: 57,
    FxTextType.d2: 45,
    FxTextType.d3: 36,

    FxTextType.h1: 32,
    FxTextType.h2: 28,
    FxTextType.h3: 26,

    FxTextType.t1: 22,
    FxTextType.t2: 16,
    FxTextType.t3: 14,

    FxTextType.l1: 14,
    FxTextType.l2: 12,
    FxTextType.l3: 11,

    FxTextType.b1: 16,
    FxTextType.b2: 14,
    FxTextType.b3: 12,
  };

  static Map<FxTextType, int> _defaultTextFontWeight = {
    FxTextType.displayLarge: 500,
    FxTextType.displayMedium: 500,
    FxTextType.displaySmall: 500,

    FxTextType.headlineLarge: 500,
    FxTextType.headlineMedium: 500,
    FxTextType.headlineSmall: 500,

    FxTextType.titleLarge: 500,
    FxTextType.titleMedium: 500,
    FxTextType.titleSmall: 500,

    FxTextType.labelLarge: 600,
    FxTextType.labelMedium: 600,
    FxTextType.labelSmall: 600,

    FxTextType.bodyLarge: 500,
    FxTextType.bodyMedium: 500,
    FxTextType.bodySmall: 500,
    //
    // // Material Design 2 (Old)
    FxTextType.h4: 500,
    FxTextType.h5: 500,
    FxTextType.h6: 500,
    FxTextType.sh1: 500,
    FxTextType.sh2: 500,
    FxTextType.button: 500,
    FxTextType.caption: 500,
    FxTextType.overline: 500,

    //Material Design 3

    FxTextType.d1: 500,
    FxTextType.d2: 500,
    FxTextType.d3: 500,

    FxTextType.h1: 500,
    FxTextType.h2: 500,
    FxTextType.h3: 500,

    FxTextType.t1: 500,
    FxTextType.t2: 500,
    FxTextType.t3: 500,

    FxTextType.l1: 600,
    FxTextType.l2: 600,
    FxTextType.l3: 600,

    FxTextType.b1: 500,
    FxTextType.b2: 500,
    FxTextType.b3: 500,
  };

  static Map<FxTextType, double> _defaultLetterSpacing = {
    FxTextType.displayLarge: -0.25,
    FxTextType.displayMedium: 0,
    FxTextType.displaySmall: 0,

    FxTextType.headlineLarge: -0.2,
    FxTextType.headlineMedium: -0.15,
    FxTextType.headlineSmall: 0,

    FxTextType.titleLarge: 0,
    FxTextType.titleMedium: 0.1,
    FxTextType.titleSmall: 0.1,

    FxTextType.labelLarge: 0.1,
    FxTextType.labelMedium: 0.5,
    FxTextType.labelSmall: 0.5,

    FxTextType.bodyLarge: 0.5,
    FxTextType.bodyMedium: 0.25,
    FxTextType.bodySmall: 0.4,
    //
    // Deprecated
    FxTextType.h4: 0,
    FxTextType.h5: 0,
    FxTextType.h6: 0,
    FxTextType.sh1: 0.15,
    FxTextType.sh2: 0.15,
    FxTextType.button: 0.15,
    FxTextType.caption: 0.15,
    FxTextType.overline: 0.15,

    //Material Design 3
    FxTextType.d1: -0.25,
    FxTextType.d2: 0,
    FxTextType.d3: 0,

    FxTextType.h1: -0.2,
    FxTextType.h2: -0.15,
    FxTextType.h3: 0,

    FxTextType.t1: 0,
    FxTextType.t2: 0.1,
    FxTextType.t3: 0.1,

    FxTextType.l1: 0.1,
    FxTextType.l2: 0.5,
    FxTextType.l3: 0.5,

    FxTextType.b1: 0.5,
    FxTextType.b2: 0.25,
    FxTextType.b3: 0.4,
  };

  @Deprecated('message')
  static TextStyle getStyle(
      {TextStyle? textStyle,
      int? fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double letterSpacing = 0.15,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    double? finalFontSize = fontSize != null
        ? fontSize
        : (textStyle == null ? 40 : textStyle.fontSize);

    Color? finalColor;
    if (color == null) {
      Color themeColor =
          FxAppTheme.getThemeFromThemeMode().colorScheme.onBackground;
      finalColor = xMuted
          ? themeColor.withAlpha(160)
          : (muted ? themeColor.withAlpha(200) : themeColor);
    } else {
      finalColor = xMuted
          ? color.withAlpha(160)
          : (muted ? color.withAlpha(200) : color);
    }

    return _fontFamily(
        fontSize: finalFontSize,
        fontWeight: _defaultFontWeight[fontWeight] ?? FontWeight.w400,
        letterSpacing: letterSpacing,
        color: finalColor,
        decoration: decoration,
        height: height,
        wordSpacing: wordSpacing);
  }

  @Deprecated('message')
  static TextStyle h4(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.h4],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.h4] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h5(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.h5],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.h5] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h6(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.h6],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.h6] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle sh1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.sh1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.sh1] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle sh2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.sh2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.sh2] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle button(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.button],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.button] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle caption(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing = 0,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.caption],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.caption] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle overline(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.overline],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.overline] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  // Material Design 3
  @Deprecated('message')
  static TextStyle d1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.d1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.d1] ?? -0.2,
        fontWeight: _defaultTextFontWeight[FxTextType.d1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle d2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.d2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.d2] ?? -0.2,
        fontWeight: _defaultTextFontWeight[FxTextType.d2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle d3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.d3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.d3] ?? -0.2,
        fontWeight: _defaultTextFontWeight[FxTextType.d3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.h1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.h1] ?? -0.2,
        fontWeight: _defaultTextFontWeight[FxTextType.h1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.h2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.h2] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.h2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.h3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.h3] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.h3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle t1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.t1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.t1] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.t1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle t2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.t2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.t2] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.t2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle t3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.t3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.t3] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.t3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle l1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.l1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.l1] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.l1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle l2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.l2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.l2] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.l2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle l3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.l3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.l3] ?? -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.l3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle b1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.b1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.b1] ?? 0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.b1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle b2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.b2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.b2] ?? 0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.b2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle b3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.b3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[FxTextType.b3] ?? 0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.b3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  // Material Design 3
  static TextStyle displayLarge(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.displayLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.displayLarge] ??
            -0.2,
        fontWeight: _defaultTextFontWeight[FxTextType.displayLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle displayMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.displayMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.displayMedium] ??
            -0.2,
        fontWeight: _defaultTextFontWeight[FxTextType.displayMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle displaySmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.displaySmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.displaySmall] ??
            -0.2,
        fontWeight: _defaultTextFontWeight[FxTextType.displaySmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle headlineLarge(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.headlineLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.headlineLarge] ??
            -0.2,
        fontWeight: _defaultTextFontWeight[FxTextType.headlineLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle headlineMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.headlineMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.headlineMedium] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.headlineMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle headlineSmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.headlineSmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.headlineSmall] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.headlineSmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle titleLarge(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.titleLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.titleLarge] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.titleLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle titleMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.titleMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.titleMedium] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.titleMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle titleSmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.titleSmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.titleSmall] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.titleSmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle labelLarge(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.labelLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.labelLarge] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.labelLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle labelMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.labelMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.labelMedium] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.labelMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle labelSmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.labelSmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.labelSmall] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.labelSmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle bodyLarge(
      {TextStyle? textStyle,
      int? fontWeight,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.bodyLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.bodyLarge] ??
            0.15,
        fontWeight:
            fontWeight ?? _defaultTextFontWeight[FxTextType.bodyLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle bodyMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.bodyMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.bodyMedium] ??
            0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.bodyMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle bodySmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[FxTextType.bodySmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[FxTextType.bodySmall] ??
            0.15,
        fontWeight: _defaultTextFontWeight[FxTextType.bodySmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static void changeFontFamily(Function fontFamily) {
    FxTextStyle._fontFamily = fontFamily;
  }

  static void changeDefaultFontWeight(Map<int, FontWeight> defaultFontWeight) {
    FxTextStyle._defaultFontWeight = defaultFontWeight;
  }

  static void changeDefaultTextSize(Map<FxTextType, double> defaultTextSize) {
    FxTextStyle._defaultTextSize = defaultTextSize;
  }

  static Map<FxTextType, double> get defaultTextSize => _defaultTextSize;

  static Map<FxTextType, double> get defaultLetterSpacing =>
      _defaultLetterSpacing;

  static Map<FxTextType, int> get defaultTextFontWeight =>
      _defaultTextFontWeight;

  static Map<int, FontWeight> get defaultFontWeight => _defaultFontWeight;

  //-------------------Reset Font Styles---------------------------------
  static resetFontStyles() {
    _fontFamily = GoogleFonts.ibmPlexSans;

    _defaultFontWeight = {
      100: FontWeight.w100,
      200: FontWeight.w200,
      300: FontWeight.w300,
      400: FontWeight.w300,
      500: FontWeight.w400,
      600: FontWeight.w500,
      700: FontWeight.w600,
      800: FontWeight.w700,
      900: FontWeight.w800,
    };

    _defaultTextSize = {
      FxTextType.displayLarge: 57,
      FxTextType.displayMedium: 45,
      FxTextType.displaySmall: 36,

      FxTextType.headlineLarge: 32,
      FxTextType.headlineMedium: 28,
      FxTextType.headlineSmall: 26,

      FxTextType.titleLarge: 22,
      FxTextType.titleMedium: 16,
      FxTextType.titleSmall: 14,

      FxTextType.labelLarge: 14,
      FxTextType.labelMedium: 12,
      FxTextType.labelSmall: 11,

      FxTextType.bodyLarge: 16,
      FxTextType.bodyMedium: 14,
      FxTextType.bodySmall: 12,

      FxTextType.h4: 36,
      FxTextType.h5: 25,
      FxTextType.h6: 21,
      FxTextType.sh1: 17,
      FxTextType.sh2: 15,
      FxTextType.button: 13,
      FxTextType.caption: 12,
      FxTextType.overline: 10,

      // Material Design 3

      FxTextType.d1: 57,
      FxTextType.d2: 45,
      FxTextType.d3: 36,

      FxTextType.h1: 32,
      FxTextType.h2: 28,
      FxTextType.h3: 26,

      FxTextType.t1: 22,
      FxTextType.t2: 16,
      FxTextType.t3: 14,

      FxTextType.l1: 14,
      FxTextType.l2: 12,
      FxTextType.l3: 11,

      FxTextType.b1: 16,
      FxTextType.b2: 14,
      FxTextType.b3: 12,
    };

    _defaultTextFontWeight = {
      FxTextType.displayLarge: 500,
      FxTextType.displayMedium: 500,
      FxTextType.displaySmall: 500,

      FxTextType.headlineLarge: 500,
      FxTextType.headlineMedium: 500,
      FxTextType.headlineSmall: 500,

      FxTextType.titleLarge: 500,
      FxTextType.titleMedium: 500,
      FxTextType.titleSmall: 500,

      FxTextType.labelLarge: 600,
      FxTextType.labelMedium: 600,
      FxTextType.labelSmall: 600,

      FxTextType.bodyLarge: 500,
      FxTextType.bodyMedium: 500,
      FxTextType.bodySmall: 500,

      // Material Design 2 (Old)
      FxTextType.h4: 500,
      FxTextType.h5: 500,
      FxTextType.h6: 500,
      FxTextType.sh1: 500,
      FxTextType.sh2: 500,
      FxTextType.button: 500,
      FxTextType.caption: 500,
      FxTextType.overline: 500,

      //Material Design 3

      FxTextType.d1: 500,
      FxTextType.d2: 500,
      FxTextType.d3: 500,

      FxTextType.h1: 500,
      FxTextType.h2: 500,
      FxTextType.h3: 500,

      FxTextType.t1: 500,
      FxTextType.t2: 500,
      FxTextType.t3: 500,

      FxTextType.l1: 600,
      FxTextType.l2: 600,
      FxTextType.l3: 600,

      FxTextType.b1: 500,
      FxTextType.b2: 500,
      FxTextType.b3: 500,
    };

    _defaultLetterSpacing = {
      FxTextType.displayLarge: -0.25,
      FxTextType.displayMedium: 0,
      FxTextType.displaySmall: 0,

      FxTextType.headlineLarge: -0.2,
      FxTextType.headlineMedium: -0.15,
      FxTextType.headlineSmall: 0,

      FxTextType.titleLarge: 0,
      FxTextType.titleMedium: 0.1,
      FxTextType.titleSmall: 0.1,

      FxTextType.labelLarge: 0.1,
      FxTextType.labelMedium: 0.5,
      FxTextType.labelSmall: 0.5,

      FxTextType.bodyLarge: 0.5,
      FxTextType.bodyMedium: 0.25,
      FxTextType.bodySmall: 0.4,

      //@deprecated
      FxTextType.h4: 0,
      FxTextType.h5: 0,
      FxTextType.h6: 0,
      FxTextType.sh1: 0.15,
      FxTextType.sh2: 0.15,
      FxTextType.button: 0.15,
      FxTextType.caption: 0.15,
      FxTextType.overline: 0.15,

      //Material Design 3
      FxTextType.d1: -0.25,
      FxTextType.d2: 0,
      FxTextType.d3: 0,

      FxTextType.h1: -0.2,
      FxTextType.h2: -0.15,
      FxTextType.h3: 0,

      FxTextType.t1: 0,
      FxTextType.t2: 0.1,
      FxTextType.t3: 0.1,

      FxTextType.l1: 0.1,
      FxTextType.l2: 0.5,
      FxTextType.l3: 0.5,

      FxTextType.b1: 0.5,
      FxTextType.b2: 0.25,
      FxTextType.b3: 0.4,
    };
  }
}
