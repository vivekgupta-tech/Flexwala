import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
/// Reusable icon button with a small numbered badge on the top-right
/// corner (used for the notification bell, and reusable for a cart/wallet
/// icon too).
class NotificationBadgeIcon extends StatelessWidget {
  final IconData icon;
  final int count;
  final VoidCallback? onTap;
  final Color iconColor;

  const NotificationBadgeIcon({
    super.key,
    required this.icon,
    required this.count,
    this.onTap,
    this.iconColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, color: iconColor, size: 24),
            if (count > 0)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  decoration: const BoxDecoration(
                    color: AppColors.badgeRed,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$count',
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
    );
  }
}

