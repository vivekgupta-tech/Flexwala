import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

/// Search field + "Filter" button row on the category page.
class CategorySearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  const CategorySearchBar({
    super.key,
    this.hintText = 'आपण काय शोधत आहात?',
    this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.searchBg,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 20, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(
                          fontSize: 13, color: AppColors.textMuted),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: onFilterTap,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.tune, size: 16, color: AppColors.primaryPurple),
                SizedBox(width: 5),
                Text('फिल्टर',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryPurple)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
