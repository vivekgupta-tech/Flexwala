import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized text styles. Every widget imports styles from HERE.
/// GoogleFonts replaced with standard TextStyle because the package is missing in pubspec.yaml.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get _base => const TextStyle(color: AppColors.textPrimary);

  // Top app bar
  static TextStyle get logoFlex => const TextStyle(
      fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary);
  static TextStyle get logoWala => logoFlex.copyWith(color: AppColors.primaryOrange);
  static TextStyle get logoTagline => _base.copyWith(
      fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textSecondary);

  // Greeting row
  static TextStyle get greeting =>
      _base.copyWith(fontSize: 18, fontWeight: FontWeight.w600);
  static TextStyle get selectBusiness =>
      const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13);

  // Promo banner
  static TextStyle get bannerEyebrow => _base.copyWith(
      fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryPurple);
  static TextStyle get bannerTitle =>
      _base.copyWith(fontSize: 26, fontWeight: FontWeight.w700, height: 1.15);
  static TextStyle get bannerTitleAccent =>
      bannerTitle.copyWith(color: AppColors.primaryOrange);
  static TextStyle get bannerSubtitle => _base.copyWith(
      fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textSecondary);
  static TextStyle get bannerCta => const TextStyle(
      color: AppColors.primaryPurple, fontWeight: FontWeight.w600, fontSize: 13);

  // Section headers (Merged/Cleaned)
  static TextStyle get sectionLink => _base.copyWith(
      fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryOrange);
  static TextStyle get sectionLinkBlue =>
      sectionLink.copyWith(color: AppColors.iconBlue);

  // Date strip
  static TextStyle get dateDay => _base.copyWith(
      fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textSecondary);
  static TextStyle get dateNumber =>
      _base.copyWith(fontSize: 18, fontWeight: FontWeight.w700);
  static TextStyle get dateNumberAccent =>
      dateNumber.copyWith(color: AppColors.primaryPurple);
  static TextStyle get dateMonth => _base.copyWith(
      fontSize: 10, fontWeight: FontWeight.w400, color: AppColors.textSecondary);

  // Template cards
  static TextStyle get templateTitle => const TextStyle(
      fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white, height: 1.15);
  static TextStyle get templateSubtitle => const TextStyle(
      fontSize: 9.5, fontWeight: FontWeight.w400, color: Colors.white70);
  static TextStyle get templatePhone => const TextStyle(
      fontSize: 9.5, fontWeight: FontWeight.w600, color: Colors.white);
  static TextStyle get templateBadge => const TextStyle(
      fontSize: 8, fontWeight: FontWeight.w600, color: Colors.white);

  // Premium banner
  static TextStyle get premiumTitle => _base.copyWith(
      fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primaryOrange);
  static TextStyle get premiumSubtitle => _base.copyWith(
      fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textSecondary);
  static TextStyle get premiumCta =>
      const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12);

  // Bottom nav
  static TextStyle get navLabel => _base.copyWith(
      fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textSecondary);
  static TextStyle get navLabelActive =>
      navLabel.copyWith(color: AppColors.primaryOrange, fontWeight: FontWeight.w600);
  static TextStyle get navLabelAccent =>
      navLabel.copyWith(color: AppColors.primaryPurple, fontWeight: FontWeight.w600);

  // Drawer
  static TextStyle get drawerTagline => _base.copyWith(
      fontSize: 10.5, fontWeight: FontWeight.w400, color: AppColors.textSecondary);
  static TextStyle get drawerName =>
      _base.copyWith(fontSize: 17, fontWeight: FontWeight.w700);
  static TextStyle get drawerBadge => _base.copyWith(
      fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primaryOrange);
  static TextStyle get drawerItemTitle =>
      _base.copyWith(fontSize: 14, fontWeight: FontWeight.w600);
  static TextStyle get drawerItemTitleDestructive =>
      drawerItemTitle.copyWith(color: AppColors.iconRed);
  static TextStyle get drawerItemSubtitle => _base.copyWith(
      fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textSecondary, height: 1.3);
  static TextStyle get drawerFooter => _base.copyWith(
      fontSize: 10, fontWeight: FontWeight.w400, color: AppColors.textMuted);

  static const TextStyle headline = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w900,
    height: 0.95,
  );

  static const TextStyle subHeadlineBold = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle featureTitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: AppColors.darkNavy,
  );

  static const TextStyle featureSubtitle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.greyText,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle website = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.darkNavy,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.darkNavy,
  );

  static const TextStyle sectionAction = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryBlue,
  );
}
