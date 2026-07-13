import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ServiceItem {
  final String title;
  final String posterCount;
  final Widget icon;

  const ServiceItem({
    required this.title,
    required this.posterCount,
    required this.icon,
  });
}

class ServiceGridItem extends StatelessWidget {
  final ServiceItem item;
  final VoidCallback? onTap;

  const ServiceGridItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.cardBorder),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 32, width: 32, child: item.icon),
            const SizedBox(height: 8),
            Text(
              item.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.posterCount,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.counterPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}