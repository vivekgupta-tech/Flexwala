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
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: AppColors.primaryPurple.withValues(alpha: 0.1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cardBorder),
          ),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 24, width: 24, child: item.icon),
              const SizedBox(height: 4),
              Flexible(
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                    height: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  item.posterCount,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: AppColors.counterPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

