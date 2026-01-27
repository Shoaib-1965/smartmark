import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF0B3D91);
  static const Color primaryLight = Color(0xFF1e4fa0);
  static const Color accent = Color(0xFF00b4d8);

  // Status Colors
  static const Color success = Color(0xFF10b981);
  static const Color error = Color(0xFFef4444);
  static const Color warning = Color(0xFFf59e0b);

  // Background Colors
  static const Color background = Color(0xFFf5f7fa);
  static const Color cardBackground = Colors.white;
  static const Color surfaceLight = Color(0xFFf3f4f6);

  // Text Colors
  static const Color textPrimary = Color(0xFF1f2937);
  static const Color textSecondary = Color(0xFF6b7280);
  static const Color textLight = Color(0xFF9ca3af);

  // Border Colors
  static const Color border = Color(0xFFd1d5db);
  static const Color borderLight = Color(0xFFe5e7eb);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, Color(0xFF0098b8)],
  );

  // Avatar Gradients
  static const List<LinearGradient> avatarGradients = [
    LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
    LinearGradient(colors: [Color(0xFF11998e), Color(0xFF38ef7d)]),
    LinearGradient(colors: [Color(0xFFfc4a1a), Color(0xFFf7b733)]),
    LinearGradient(colors: [Color(0xFF00b4db), Color(0xFF0083b0)]),
    LinearGradient(colors: [Color(0xFFee0979), Color(0xFFff6a00)]),
    LinearGradient(colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)]),
  ];
}
