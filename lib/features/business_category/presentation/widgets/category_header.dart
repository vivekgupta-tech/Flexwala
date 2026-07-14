import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Top header for the Business Category page (matches reference design):
/// hamburger · mascot logo · Flexwala text + tagline · Pro Premium · bell · wallet.
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Hamburger
        InkWell(
          onTap: onMenuTap,
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: Icon(Icons.menu, size: 24, color: AppColors.textPrimary),
          ),
        ),
        const SizedBox(width: 8),
        // Mascot logo image
        Image.asset(
          'assets/images/logopng.png',
          width: 42,
          height: 42,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFEDE3FF),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.storefront, size: 20, color: AppColors.primaryPurple),
          ),
        ),
        const SizedBox(width: 8),
        // Brand text: Flexwala + tagline
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  style: AppTextStyles.logoText.copyWith(fontSize: 18),
                  children: const [
                    TextSpan(
                      text: 'Flex',
                      style: TextStyle(color: AppColors.primaryOrange),
                    ),
                    TextSpan(
                      text: 'walá',
                      style: TextStyle(
                        color: AppColors.primaryPurple,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'डिजिटल ओळख + ब्रँडिंग प्लॅटफॉर्म',
                style: AppTextStyles.logoTagline.copyWith(fontSize: 8),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        // Pro Premium badge
        InkWell(
          onTap: onProTap,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.iconBgOrange,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.workspace_premium, size: 14, color: AppColors.primaryOrange),
                const SizedBox(width: 4),
                Text(
                  'Pro\nPremium',
                  style: AppTextStyles.proBadge.copyWith(fontSize: 9),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Notification bell
        InkWell(
          onTap: onBellTap,
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  size: 18,
                  color: AppColors.textPrimary,
                ),
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                    decoration: const BoxDecoration(
                      color: AppColors.badgeRed,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 7,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        // Wallet button
        InkWell(
          onTap: onWalletTap,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: Container(
            width: 32,
            height: 32,
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
