import 'package:flutter/material.dart';
import 'package:flexify/core/theme/app_colors.dart';
import 'flexwala_logo.dart';

/// Reusable top app bar: back button + centered brand logo + like icon.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onLikeTap;
  final bool isLiked;

  const CustomAppBar({
    super.key,
    this.onBackTap,
    this.onLikeTap,
    this.isLiked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cardWhite,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 52,
          child: Row(
            children: [
              IconButton(
                onPressed: onBackTap,
                icon: const Icon(Icons.arrow_back, color: AppColors.darkNavy),
              ),
              const Expanded(
                child: Center(
                  child: FlexwalaLogo(fontSize: 20, iconSize: 24),
                ),
              ),
              IconButton(
                onPressed: onLikeTap,
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.darkNavy,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(52);
}
