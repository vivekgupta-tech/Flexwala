import 'package:flutter/material.dart';
import 'package:flexwala/core/theme/app_colors.dart';

/// Wires colors + text styles into a single ThemeData.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        primary: AppColors.primaryBlue,
        secondary: AppColors.primaryOrange,
        surface: AppColors.cardWhite,
        onSurface: AppColors.textDark,
        surfaceContainerHighest: AppColors.searchBg,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.darkNavy,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.darkNavy),
      ),
      dividerColor: AppColors.borderLight,
      splashFactory: InkRipple.splashFactory,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate 900
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        brightness: Brightness.dark,
        primary: AppColors.primaryBlue,
        secondary: AppColors.primaryOrange,
        surface: const Color(0xFF1E293B), // Slate 800
        onSurface: Colors.white,
        surfaceContainerHighest: const Color(0xFF334155), // Slate 700
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E293B),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      dividerColor: Colors.white12,
      splashFactory: InkRipple.splashFactory,
    );
  }

  // Purana 'light' getter agar kahin use ho raha ho toh usse redirect kar dete hain
  static ThemeData get light => lightTheme;
  static ThemeData get dark => darkTheme;
}

