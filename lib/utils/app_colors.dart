import 'package:flutter/material.dart';

class AppColors {
  // Primary color palette - Updated to use the pinkish color as primary
  static const Color primary = Color(0xFFBF7587);      // #BF7587 - Pink (now primary)
  static const Color secondary = Color(0xFFE68057);    // #E68057 - Orange
  static const Color tertiary = Color(0xFFA2574F);     // #A2574F - Reddish brown
  static const Color accent = Color(0xFF993A8B);       // #993A8B - Purple

  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary, tertiary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient horizontalGradient = LinearGradient(
    colors: [primary, secondary, tertiary, accent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient verticalGradient = LinearGradient(
    colors: [primary, secondary, tertiary, accent],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Lighter variations for backgrounds
  static const Color primaryLight = Color(0xFFCA8A9A);
  static const Color secondaryLight = Color(0xFFEA9470);
  static const Color tertiaryLight = Color(0xFFB86B63);
  static const Color accentLight = Color(0xFFA6529E);

  // Darker variations for text and emphasis
  static const Color primaryDark = Color(0xFFAB6575);
  static const Color secondaryDark = Color(0xFFD16B47);
  static const Color tertiaryDark = Color(0xFF8A4A44);
  static const Color accentDark = Color(0xFF7F2F73);

  // Neutral colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF6B7280);
  static const Color lightGrey = Color(0xFFF3F4F6);
  static const Color darkGrey = Color(0xFF374151);

  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Background colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  // Text colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
} 