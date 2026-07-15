import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/placeholder_box.dart';

/// "Grow Your Business — Professional Branding" promo banner with a
/// dot-indicator carousel (page state kept internal for now).
class BannerCarousel extends StatefulWidget {
  final VoidCallback? onExploreTap;

  const BannerCarousel({super.key, this.onExploreTap});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final int _activeDot = 0;
  final int _dotCount = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.bannerBackgroundStart, AppColors.bannerBackgroundEnd],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Grow Your Business', style: AppTextStyles.bannerEyebrow),
                      const SizedBox(height: 6),
                      Text('Professional', style: AppTextStyles.bannerTitle),
                      Text('Branding', style: AppTextStyles.bannerTitleAccent),
                      const SizedBox(height: 8),
                      Text(
                        'High quality templates\nfor every need',
                        style: AppTextStyles.bannerBody,
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: InkWell(
                          onTap: widget.onExploreTap,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Explore Now', style: AppTextStyles.bannerCta),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward,
                                size: 14,
                                color: AppColors.primaryPurple,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 5,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      const PlaceholderBox(
                        width: double.infinity,
                        height: 150,
                        icon: Icons.person_outline,
                        backgroundColor: Color(0xFFE9E4FB),
                        iconColor: AppColors.primaryPurple,
                        iconSize: 40,
                      ),
                      Positioned(
                        top: 4,
                        left: 4,
                        child: PlaceholderBox(
                          width: 32,
                          height: 32,
                          borderRadius: AppRadius.sm,
                          icon: Icons.show_chart,
                          backgroundColor: AppColors.primaryPurple,
                          iconColor: Colors.white,
                          iconSize: 16,
                        ),
                      ),
                      Positioned(
                        top: 30,
                        right: -6,
                        child: PlaceholderBox(
                          width: 32,
                          height: 32,
                          borderRadius: AppRadius.sm,
                          icon: Icons.pedal_bike,
                          backgroundColor: Colors.white,
                          iconColor: AppColors.primaryPurple,
                          iconSize: 16,
                        ),
                      ),
                      Positioned(
                        right: 6,
                        bottom: 26,
                        child: PlaceholderBox(
                          width: 32,
                          height: 32,
                          borderRadius: AppRadius.sm,
                          icon: Icons.title,
                          backgroundColor: AppColors.primaryPurple,
                          iconColor: Colors.white,
                          iconSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_dotCount, (i) {
              final bool active = i == _activeDot;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: active ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: active ? AppColors.primaryOrange : AppColors.dotInactive,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

