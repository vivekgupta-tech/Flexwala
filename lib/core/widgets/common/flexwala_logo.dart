import 'package:flutter/material.dart';

import 'package:flexify/core/theme/app_colors.dart';

/// Reusable brand logo - "FLEX" (orange) + "WALA" (blue).
/// fontSize/iconSize alag-alag jagah (appbar vs poster) ke liye configurable.
class FlexwalaLogo extends StatelessWidget {
  final double fontSize;
  final double iconSize;

  const FlexwalaLogo({
    super.key,
    this.fontSize = 18,
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.bolt, color: AppColors.primaryOrange, size: iconSize),
        const SizedBox(width: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'FLEX',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryOrange,
                ),
              ),
              TextSpan(
                text: 'WALA',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
