import 'package:flutter/material.dart';
import 'package:flexwala/core/theme/app_colors.dart';

/// Wires colors + text styles into a single ThemeData.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: null, // <- Yahan apna custom font name daal sakte hain
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        primary: AppColors.primaryBlue,
        secondary: AppColors.primaryOrange,
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

  // Purana 'light' getter agar kahin use ho raha ho toh usse redirect kar dete hain
  static ThemeData get light => lightTheme;
}

