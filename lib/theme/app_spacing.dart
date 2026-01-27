import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  // Spacing
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 40.0;

  // Border Radius
  static BorderRadius get radiusSm => BorderRadius.circular(6);
  static BorderRadius get radiusMd => BorderRadius.circular(8);
  static BorderRadius get radiusLg => BorderRadius.circular(12);
  static BorderRadius get radiusXl => BorderRadius.circular(16);
  static BorderRadius get radiusCircle => BorderRadius.circular(24);

  // Padding
  static const EdgeInsets paddingSm = EdgeInsets.all(8);
  static const EdgeInsets paddingMd = EdgeInsets.all(16);
  static const EdgeInsets paddingLg = EdgeInsets.all(24);

  static const EdgeInsets paddingHorizontalSm = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets paddingHorizontalMd = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(horizontal: 24);

  static const EdgeInsets paddingVerticalSm = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets paddingVerticalMd = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets paddingVerticalLg = EdgeInsets.symmetric(vertical: 24);

  // Button
  static const double buttonHeight = 48.0;
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 12);

  // Input
  static const double inputHeight = 48.0;
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
}
