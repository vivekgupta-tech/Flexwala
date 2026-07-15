import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Home > सर्व कॅटेगरी > Business  breadcrumb trail.
class CategoryBreadcrumb extends StatelessWidget {
  final List<String> trail;
  final VoidCallback? onHomeTap;

  const CategoryBreadcrumb({
    super.key,
    required this.trail,
    this.onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onHomeTap,
          child: const Icon(Icons.home_outlined, size: 15, color: AppColors.textGrey),
        ),
        for (int i = 0; i < trail.length; i++) ...[
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right, size: 14, color: AppColors.textGrey),
          const SizedBox(width: 6),
          Text(
            trail[i],
            style: i == trail.length - 1
                ? AppTextStyles.breadcrumbActive
                : AppTextStyles.breadcrumb,
          ),
        ],
      ],
    );
  }
}

