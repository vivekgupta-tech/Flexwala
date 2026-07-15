import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color background = Color(0xFFFBF3E8);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color darkNavy = Color(0xFF0F1B3D);
  static const Color primaryOrange = Color(0xFFF5821F);
  static const Color primaryBlue = Color(0xFF1D4ED8);
  static const Color hexOrange = Color(0xFFF5821F);
  static const Color hexBlue = Color(0xFF1D4ED8);
  static const Color greyText = Color(0xFF6B7280);
  static const Color dotInactive = Color(0xFFD9D9D9);
  static const Color borderLight = Color(0xFFE5E5E5);

  static const primaryPurple = Color(0xFF7B2FF7);

  static const brandGradient = LinearGradient(
    colors: [primaryOrange, primaryPurple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const brandGradientDiagonal = LinearGradient(
    colors: [primaryOrange, primaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text
  static const textPrimary = Color(0xFF1A1A2E);
  static const textSecondary = Color(0xFF6B7280);
  static const textMuted = Color(0xFF9CA3AF);

  // Backgrounds
  static const scaffoldBackground = Color(0xFFFFFFFF);
  static const bannerBackgroundStart = Color(0xFFEDE7FF);
  static const bannerBackgroundEnd = Color(0xFFFFEDE3);
  static const premiumBannerBackground = Color(0xFFFFF1EC);
  static const cardBackground = Color(0xFFFFFFFF);

  // Semantic icon-circle backgrounds
  static const iconBgOrange = Color(0xFFFFE8D6);
  static const iconBgPeach = Color(0xFFFFE3D6);
  static const iconBgBlue = Color(0xFFDCEEFE);
  static const iconBgPurple = Color(0xFFEDE3FF);
  static const iconBgGreen = Color(0xFFDCF5E3);
  static const iconBgPink = Color(0xFFFDE3EE);
  static const iconBgRed = Color(0xFFFFE3E3);

  static const iconOrange = primaryOrange;
  static const iconBlue = Color(0xFF2F80ED);
  static const iconPurple = primaryPurple;
  static const iconGreen = Color(0xFF27AE60);
  static const iconPink = Color(0xFFEB5C96);
  static const iconRed = Color(0xFFEB5757);

  static const templateNavyBlue = Color(0xFF14213D);
  static const badgeRed = Color(0xFFFF4D4D);
  static const dividerColor = Color(0xFFEFEFEF);
  static const chipInactiveBg = Color(0xFFF7F7F9);


  // Home screen
  static const Color bannerStart = Color(0xFF6D28D9);
  static const Color bannerEnd = Color(0xFF7C3AED);
  static const Color bannerBg = Color(0xFFEDE9FE);
  static const Color searchBg = Color(0xFFF5F5F7);
  static const Color cardBorder = Color(0xFFEDEDF2);
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textGrey = Color(0xFF9B9BA8);
  static const Color counterPurple = Color(0xFF7C3AED);

  // Category screen
  static const Color pageBg = Color(0xFFFBF7F2);
  static const Color businessOrange = Color(0xFFF97316);
  static const Color politicalBlue = Color(0xFF2563EB);
  static const Color personalPurple = Color(0xFF9333EA);
  static const Color devotionalRed = Color(0xFFDC2626);
  static const Color royalYellow = Color(0xFFEAB308);
  static const Color festivalGreen = Color(0xFF16A34A);

  static const Color navActive = Color(0xFFF97316);
  static const Color navInactive = Color(0xFF9B9BA8);


}

