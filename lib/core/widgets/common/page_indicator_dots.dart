import 'package:flutter/material.dart';

import 'package:flexify/core/theme/app_colors.dart';

/// Reusable dot page indicator - active dot has orange->blue gradient.
class PageIndicatorDots extends StatelessWidget {
  final int totalPages;
  final int activeIndex;

  const PageIndicatorDots({
    super.key,
    required this.totalPages,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final isActive = index == activeIndex;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isActive
                ? const LinearGradient(
                    colors: [AppColors.primaryOrange, AppColors.primaryBlue],
                  )
                : null,
            color: isActive ? null : AppColors.dotInactive,
          ),
        );
      }),
    );
  }
}
