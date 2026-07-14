import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/category_item.dart';

/// A single tile in the Business category grid: rounded card, emoji-style
/// icon in a soft circle, heart/favorite toggle top-right, name + post
/// count below.
class CategoryGridTile extends StatelessWidget {
  final CategoryItem item;
  final VoidCallback? onTap;
  final ValueChanged<CategoryItem>? onFavoriteTap;

  const CategoryGridTile({
    super.key,
    required this.item,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: item.iconBackground,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(item.emojiIcon, size: 22, color: AppColors.textDark),
                ),
                Positioned(
                  right: -6,
                  top: -4,
                  child: InkWell(
                    onTap: () => onFavoriteTap?.call(item),
                    child: Icon(
                      item.isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 14,
                      color: item.isFavorite ? AppColors.badgeRed : AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              item.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.categoryName.copyWith(fontSize: 10),
            ),
            const SizedBox(height: 2),
            Text(
              '${item.postCount}+ पोस्टर',
              style: AppTextStyles.categoryCount.copyWith(fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }
}
