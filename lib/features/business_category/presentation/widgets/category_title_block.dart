import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Icon + "Business" title + Marathi subtitle shown above the grid.
class CategoryTitleBlock extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const CategoryTitleBlock({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.storefront_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.iconBgPurple,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 26, color: AppColors.primaryPurple),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.pageTitle),
              const SizedBox(height: 3),
              Text(subtitle, style: AppTextStyles.pageSubtitle),
            ],
          ),
        ),
      ],
    );
  }
}

