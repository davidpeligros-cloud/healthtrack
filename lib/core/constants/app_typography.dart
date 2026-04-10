import 'package:flutter/material.dart';

abstract class AppTypography {
  static const String fontFamily = 'SF Pro Display';
  static const String fontFamilyRounded = 'SF Pro Rounded';

  static const TextStyle largeTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 34,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.37,
    height: 1.2,
  );

  static const TextStyle title1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.36,
    height: 1.2,
  );

  static const TextStyle title2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.35,
    height: 1.3,
  );

  static const TextStyle title3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.38,
    height: 1.25,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.41,
    height: 1.3,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.41,
    height: 1.4,
  );

  static const TextStyle callout = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.32,
    height: 1.35,
  );

  static const TextStyle subheadline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.24,
    height: 1.35,
  );

  static const TextStyle footnote = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.08,
    height: 1.4,
  );

  static const TextStyle caption1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.3,
  );

  static const TextStyle caption2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.07,
    height: 1.2,
  );

  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamilyRounded,
    fontSize: 56,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 1.1,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamilyRounded,
    fontSize: 44,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 1.1,
  );
}
