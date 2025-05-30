import 'package:flutter/material.dart';

class ThemeColors {
  static Color primary(BuildContext context) => 
    Theme.of(context).brightness == Brightness.light 
      ? const Color(0xFFFFFFFF)
      : const Color(0xFF1A1A1A);

  static Color primaryDark(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0xFF002855)
      : const Color(0xFF001830);

  static Color accent(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0xFF1D1D1D)
      : const Color(0xFFE0E0E0);

  static Color iconColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0xFF1D1D1D)
      : const Color(0xFFE0E0E0);

  static Color text (BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0xFF1D1D1D)
      : const Color(0xFFE0E0E0);

  static Color secondary(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFFFC20E)
      : const Color(0xFFFFD54F);

  // Warna background dan surface
  static Color background(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? Colors.white
      : const Color(0xFF121212);

  static Color surface(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFF5F5F5)
      : const Color(0xFF1E1E1E);

  static Color cardBackground(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? Colors.white
      : const Color(0xFF2D2D2D);

  // Warna teks
  static Color textPrimary(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0xFF000000)
      : Colors.white;

  static Color textSecondary(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0xFF6B7280)
      : const Color(0xFFB0B0B0);

  static Color textGrey(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0xFF9CA3AF)
      : const Color(0xFF787878);

  // Warna status dan feedback
  static const Color success = Color(0xFF059669);
  static const Color error = Color(0xFFDC2626);
  static const Color warning = Color(0xFFFFC20E);
  static const Color info = Color(0xFF00BFF3);

  // Warna input dan button
  static Color inputFill(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFF3F4F6)
      : const Color(0xFF2D2D2D);

  static Color inputBorder(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFE5E7EB)
      : const Color(0xFF404040);

  static Color inputIcon(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0xFF000000)
      : Colors.white;

  static Color buttonText(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? Colors.white
      : Colors.black;

  static Color buttonDisabled(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0xFFE5E7EB)
      : const Color(0xFF404040);

  // Warna bayangan
  static Color shadowColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
      ? const Color(0x1A000000)
      : const Color(0x1AFFFFFF);

  // Theme data untuk light dan dark mode
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFFFFFF),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFFFFFFF),
      secondary: Color(0xFFFFC20E),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1A1A1A),
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF1A1A1A),
      secondary: Color(0xFFFFD54F),
    ),
  );
} 