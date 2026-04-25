import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LinkUpColors {
  static const Color green = Color(0xFF0F4F47);
  static const Color greenDark = Color(0xFF0A3A34);
  static const Color navy = Color(0xFF142F4C);
  static const Color navyDark = Color(0xFF0A2138);
  static const Color gold = Color(0xFFC9A24F);
  static const Color goldDark = Color(0xFF8A6F1F);
  static const Color cream = Color(0xFFF5ECD7);
  static const Color background = Color(0xFFF5F2EC);
  static const Color surface = Colors.white;
  static const Color surfaceTint = Color(0xFFFAF7F1);
  static const Color border = Color(0xFFEFEAE0);
  static const Color borderStrong = Color(0xFFE8E2D6);
  static const Color textPrimary = Color(0xFF1A1F1D);
  static const Color textSecondary = Color(0xFF4A524F);
  static const Color textMuted = Color(0xFF8A918E);
  static const Color textDisabled = Color(0xFFD4CFC1);
  static const Color success = Color(0xFF2E8B6A);
  static const Color successFg = Color(0xFF1F6B4F);
  static const Color successBg = Color(0xFFDDF0E6);
  static const Color danger = Color(0xFFC44A3D);
  static const Color dangerFg = Color(0xFFA93D31);
  static const Color dangerBg = Color(0xFFFBE4E0);
  static const Color pillGreenBg = Color(0xFFE5EDEB);
  static const Color pillNavyBg = Color(0xFFE8ECF1);
  static const Color pillNeutralBg = Color(0xFFEFEAE0);
  static const Color pillNeutralFg = Color(0xFF4A524F);
}

ThemeData buildLinkUpTheme() {
  final base = ThemeData.light(useMaterial3: true);
  final textTheme = GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
    bodyColor: LinkUpColors.textPrimary,
    displayColor: LinkUpColors.textPrimary,
  );
  return base.copyWith(
    scaffoldBackgroundColor: LinkUpColors.background,
    colorScheme: const ColorScheme.light(
      primary: LinkUpColors.green,
      onPrimary: Colors.white,
      secondary: LinkUpColors.gold,
      onSecondary: LinkUpColors.navy,
      surface: Colors.white,
      onSurface: LinkUpColors.textPrimary,
      error: LinkUpColors.danger,
    ),
    textTheme: textTheme,
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}

TextStyle linkupMono({double size = 11, FontWeight weight = FontWeight.w700, Color? color}) {
  return GoogleFonts.jetBrainsMono(
    fontSize: size,
    fontWeight: weight,
    color: color ?? LinkUpColors.textPrimary,
    letterSpacing: 0.05,
  );
}

TextStyle linkupSerif({double size = 28, Color? color}) {
  return GoogleFonts.fraunces(
    fontSize: size,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: color ?? LinkUpColors.gold,
  );
}
