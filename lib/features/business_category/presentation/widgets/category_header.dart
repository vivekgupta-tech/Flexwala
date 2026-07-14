import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/placeholder_box.dart';

/// Top header for the Business Category page: hamburger · logo + tagline ·
/// Pro Premium badge · notification bell · wallet icon.
class CategoryHeader extends StatelessWidget {
  final int notificationCount;
  final VoidCallback? onMenuTap;
  final VoidCallback? onProTap;
  final VoidCallback? onBellTap;
  final VoidCallback? onWalletTap;

  const CategoryHeader({
    super.key,
    this.notificationCount = 0,
    this.onMenuTap,
    this.onProTap,
    this.onBellTap,
    this.onWalletTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onMenuTap,
          borderRadius: BorderRadius.circular(8),
          child: const Icon(Icons.menu, size: 24, color: AppColors.textPrimary),
        ),
        const SizedBox(width: 10),
        const PlaceholderBox(
          width: 38,
          height: 38,
          borderRadius: 38,
          icon: Icons.person,
          backgroundColor: Color(0xFFEDE3FF),
          iconColor: AppColors.primaryPurple,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  style: AppTextStyles.logoText.copyWith(fontSize: 19),
                  children: const [
                    TextSpan(
                      text: 'Flex',
                      style: TextStyle(color: AppColors.primaryOrange),
                    ),
                    TextSpan(
                      text: 'wala',
                      style: TextStyle(
                        color: AppColors.primaryPurple,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'डिजिटल ओळख + ब्रॅंडिंग प्लॅटफॉर्म',
                style: AppTextStyles.logoTagline.copyWith(fontSize: 8),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: onProTap,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.iconBgOrange,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.workspace_premium,
                  size: 14,
                  color: AppColors.primaryOrange,
                ),
                const SizedBox(width: 4),
                Text('Pro\nPremium', style: AppTextStyles.proBadge.copyWith(fontSize: 10), textAlign: TextAlign.left),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: onBellTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.notifications_none_rounded,
                size: 22,
                color: AppColors.textPrimary,
              ),
              if (notificationCount > 0)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    constraints: const BoxConstraints(minWidth: 15, minHeight: 15),
                    decoration: const BoxDecoration(
                      color: AppColors.badgeRed,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: onWalletTap,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.primaryPurple,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
