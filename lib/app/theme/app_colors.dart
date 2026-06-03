import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary
  static const primary = Color(0xFF2E437D);
  static const primaryLight = Color(0xFF5D73B2);
  static const primaryDark = Color(0xFF1D2E5A);

  // Secondary
  static const secondary = Color(0xFF4A90E2);

  // Status
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);

  // Neutral
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  // Grey Scale
  static const grey50 = Color(0xFFF9FAFB);
  static const grey100 = Color(0xFFF3F4F6);
  static const grey200 = Color(0xFFE5E7EB);
  static const grey300 = Color(0xFFD1D5DB);
  static const grey400 = Color(0xFF9CA3AF);
  static const grey500 = Color(0xFF6B7280);
  static const grey600 = Color(0xFF4B5563);
  static const grey700 = Color(0xFF374151);
  static const grey800 = Color(0xFF1F2937);
  static const grey900 = Color(0xFF111827);

  // Light Theme
  static const lightBackground = Color(0xFFF8FAFC);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFFFFFFF);

  // Dark Theme
  static const darkBackground = Color(0xFF0F172A);
  static const darkSurface = Color(0xFF1E293B);
  static const darkCard = Color(0xFF334155);

  // Text Light
  static const textPrimaryLight = Color(0xFF111827);
  static const textSecondaryLight = Color(0xFF6B7280);

  // Text Dark
  static const textPrimaryDark = Color(0xFFF8FAFC);
  static const textSecondaryDark = Color(0xFFCBD5E1);

  // Divider
  static const dividerLight = Color(0xFFE5E7EB);
  static const dividerDark = Color(0xFF334155);

  // Disabled
  static const disabled = Color(0xFF9CA3AF);

  // Transparent
  static const transparent = Colors.transparent;
}