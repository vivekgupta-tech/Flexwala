import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';

/// "Hai <Name> 👋"  +  gradient "Select Business ▾" button.
class GreetingRow extends StatelessWidget {
  final String userName;
  final VoidCallback? onSelectBusinessTap;

  const GreetingRow({
    super.key,
    required this.userName,
    this.onSelectBusinessTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Hai $userName 👋', style: AppTextStyles.greeting),
        InkWell(
          onTap: onSelectBusinessTap,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              gradient: AppColors.brandGradient,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Select Business', style: AppTextStyles.buttonLabel),
                const SizedBox(width: 6),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
