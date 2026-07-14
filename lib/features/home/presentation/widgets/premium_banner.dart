import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';

/// "Unlock Premium Benefits" upsell banner shared by Home & Category pages.
class PremiumBanner extends StatelessWidget {
  final String title;
  final String body;
  final String ctaLabel;
  final IconData icon;
  final VoidCallback? onTap;

  const PremiumBanner({
    super.key,
    this.title = 'Unlock Premium Benefits',
    this.body = 'Get unlimited downloads and\npremium templates.',
    this.ctaLabel = 'Upgrade Now',
    this.icon = Icons.workspace_premium,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.premiumBannerBackground,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              gradient: AppColors.brandGradientDiagonal,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.premiumTitle),
                const SizedBox(height: 3),
                Text(body, style: AppTextStyles.premiumBody),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                ctaLabel,
                style: AppTextStyles.buttonLabel.copyWith(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
