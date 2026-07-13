import 'package:flutter/material.dart';

import 'package:flexify/core/theme/app_colors.dart';

import '../../theme/app_text_styles.dart';


/// Reusable section title + trailing "See All ›" action link.
class SectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel = 'See All',
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.sectionTitle),
        InkWell(
          onTap: onActionTap,
          child: Row(
            children: [
              Text(actionLabel, style: AppTextStyles.sectionAction),
              const Icon(Icons.chevron_right, color: AppColors.primaryBlue),
            ],
          ),
        ),
      ],
    );
  }
}
