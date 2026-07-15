import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized text styles. Every widget imports styles from HERE.
/// GoogleFonts replaced with standard TextStyle because the package is
/// missing in pubspec.yaml.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle logoText = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.0,
  );

  static TextStyle logoTagline = const TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
  );

  static TextStyle greeting = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle buttonLabel = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle sectionTitle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle sectionLink = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryOrange,
  );

  static TextStyle bannerEyebrow = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryPurple,
  );

  static TextStyle bannerTitle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.15,
  );

  static TextStyle bannerTitleAccent = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryOrange,
    height: 1.15,
  );

  static TextStyle bannerBody = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle bannerCta = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryPurple,
  );

  static TextStyle dateDay = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.textGrey,
  );

  static TextStyle dateNumber = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static TextStyle dateMonth = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textGrey,
  );

  static TextStyle templateTitle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 1.2,
  );

  static TextStyle templateSubtitle = const TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );

  static TextStyle premiumTitle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle premiumBody = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle navLabel = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.navInactive,
  );

  static TextStyle navLabelActive = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.navActive,
  );

  // Category screen
  static TextStyle breadcrumb = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textGrey,
  );

  static TextStyle breadcrumbActive = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryPurple,
  );

  static TextStyle pageTitle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle pageSubtitle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
  );

  static TextStyle categoryName = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static TextStyle categoryCount = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.counterPurple,
  );

  static TextStyle proBadge = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryOrange,
  );

  static TextStyle website = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle buttonText = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle featureTitle = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static TextStyle featureSubtitle = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
  );

  static TextStyle sectionAction = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryPurple,
  );
}

