import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/template_item.dart';

/// "Today's Templates" section header + horizontal poster cards with a
/// heart/favorite toggle in the top-right corner of each card.
class TemplatesSection extends StatelessWidget {
  final List<TemplateItem> templates;
  final VoidCallback? onSeeAllTap;
  final ValueChanged<TemplateItem>? onFavoriteTap;

  const TemplatesSection({
    super.key,
    required this.templates,
    this.onSeeAllTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  size: 16,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: 6),
                Text("Today's Templates", style: AppTextStyles.sectionTitle),
              ],
            ),
            InkWell(
              onTap: onSeeAllTap,
              child: Row(
                children: [
                  Text(
                    'See All',
                    style: AppTextStyles.sectionLink.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.arrow_forward,
                    size: 13,
                    color: AppColors.primaryBlue,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: templates.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final t = templates[index];
              return Container(
                width: 130,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: t.backgroundColor,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.title,
                          style: AppTextStyles.templateTitle,
                          maxLines: 2,
                        ),
                        const Spacer(),
                        Text(
                          t.subtitle,
                          style: AppTextStyles.templateSubtitle,
                          maxLines: 3,
                        ),
                        if (t.phone.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.call,
                                size: 10,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  t.phone,
                                  style: AppTextStyles.templateSubtitle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => onFavoriteTap?.call(t),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            t.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 13,
                            color: t.isFavorite
                                ? AppColors.badgeRed
                                : AppColors.textMuted,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
