import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Top header: hamburger menu · Flexwala logo + tagline · notification bell.
class HomeHeader extends StatelessWidget {
  final int notificationCount;
  final VoidCallback? onMenuTap;
  final VoidCallback? onBellTap;

  const HomeHeader({
    super.key,
    this.notificationCount = 0,
    this.onMenuTap,
    this.onBellTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onMenuTap,
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.menu, size: 26, color: AppColors.textPrimary),
          ),
        ),
        Expanded(
          child: Center(
            child: Image.asset(
              'assets/images/topappbarpng.png',
              height: 54,
              fit: BoxFit.contain,
            ),
          ),
        ),
        InkWell(
          onTap: onBellTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  size: 26,
                  color: AppColors.textPrimary,
                ),
                if (notificationCount > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.badgeRed,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$notificationCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

