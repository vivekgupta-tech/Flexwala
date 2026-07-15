import 'package:flutter/material.dart';

import 'package:flexwala/core/theme/app_colors.dart';

import '../../../../core/theme/app_text_styles.dart';


/// Reusable pill-shaped CTA button with trailing arrow (e.g. "JOIN NOW").
class JoinNowButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const JoinNowButton({
    super.key,
    this.label = 'JOIN NOW',
    this.color = AppColors.primaryBlue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: AppTextStyles.buttonText),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

