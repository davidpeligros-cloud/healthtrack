import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color backgroundPrimary = Color(0xFFFAFAFA);
  static const Color backgroundSecondary = Color(0xFFFFFFFF);
  static const Color backgroundTertiary = Color(0xFFF5F5F7);
  static const Color backgroundPrimaryDark = Color(0xFF000000);
  static const Color backgroundSecondaryDark = Color(0xFF1C1C1E);
  static const Color backgroundTertiaryDark = Color(0xFF2C2C2E);
  static const Color textPrimary = Color(0xFF1D1D1F);
  static const Color textSecondary = Color(0xFF86868B);
  static const Color textTertiary = Color(0xFFAEAEB2);
  static const Color textPrimaryDark = Color(0xFFF5F5F7);
  static const Color textSecondaryDark = Color(0xFF98989D);
  static const Color accentGreen = Color(0xFF34C759);
  static const Color accentBlue = Color(0xFF007AFF);
  static const Color accentPink = Color(0xFFFF2D55);
  static const Color accentOrange = Color(0xFFFF9500);
  static const Color accentPurple = Color(0xFFAF52DE);
  static const Color accentTeal = Color(0xFF5AC8FA);
  static const Color chartProtein = Color(0xFFFFB3BA);
  static const Color chartCarbs = Color(0xFFBAE1FF);
  static const Color chartFat = Color(0xFFFFDFBA);
  static const Color chartFiber = Color(0xFFBAFFBA);
  static const Color separator = Color(0xFFE5E5EA);
  static const Color separatorDark = Color(0xFF38383A);
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF007AFF), Color(0xFF5856D6)],
  );
  static const LinearGradient calorieRingGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF34C759), Color(0xFF30D158)],
  );
}
