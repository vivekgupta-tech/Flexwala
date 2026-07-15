import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/navigation/app_bottom_nav.dart';
import '../../home/presentation/widgets/premium_banner.dart';
import '../data/business_category_mock_data.dart';
import 'widgets/category_header.dart';
import 'widgets/category_search_bar.dart';
import 'widgets/category_breadcrumb.dart';
import 'widgets/category_title_block.dart';
import '../domain/category_item.dart';

/// Business Category screen — closely matches the reference design:
/// header, search+filter, breadcrumb, title block, 5×4 grid, premium upsell, bottom nav.
class BusinessCategoryPage extends StatelessWidget {
  const BusinessCategoryPage({super.key});

  void _showComingSoon(BuildContext context, String item) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$item — Coming Soon!'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.primaryPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FC),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 16, 0),
              child: CategoryHeader(notificationCount: 3),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                physics: const BouncingScrollPhysics(),
                children: [
                  const CategorySearchBar(),
                  const SizedBox(height: 12),
                  const CategoryBreadcrumb(
                    trail: ['होम', 'सर्व कॅटेगरी', 'Business'],
                  ),
                  const SizedBox(height: 14),
                  const CategoryTitleBlock(
                    title: 'Business',
                    subtitle: 'आपल्या व्यवसासाठी योग्य कॅटेगरी निवडा',
                    icon: Icons.storefront_outlined,
                  ),
                  const SizedBox(height: 14),
                  // 5-column grid — matches reference
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: BusinessCategoryMockData.categories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      childAspectRatio: 0.64, // Sufficient height for 2-line text and count
                    ),
                    itemBuilder: (context, index) {
                      final item = BusinessCategoryMockData.categories[index];
                      return _BusinessGridTile(
                        item: item,
                        onTap: () => _showComingSoon(context, item.name),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const PremiumBanner(
                    title: 'सर्व प्रीमियम डिझाईन्स अनलॉक करा',
                    body: 'अमर्याद पोस्टर डाउनलोड आणि विशेष सुविधा मिळवा.',
                    ctaLabel: 'Pro मध्ये अपग्रेड करा',
                    icon: Icons.phonelink_lock,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onItemTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/home');
          if (index == 1) Navigator.pushReplacementNamed(context, '/category');
        },
        onCenterTap: () => Navigator.pushReplacementNamed(context, '/home'),
      ),
    );
  }
}

/// Individual grid tile for the Business category grid.
class _BusinessGridTile extends StatelessWidget {
  final CategoryItem item;
  final VoidCallback? onTap;

  const _BusinessGridTile({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        splashColor: AppColors.primaryPurple.withValues(alpha: 0.1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon area with soft background circle
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: item.iconBackground,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      item.emojiIcon,
                      size: 18,
                      color: AppColors.textDark,
                    ),
                  ),
                  // Heart icon top-right
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Icon(
                      item.isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 12,
                      color: item.isFavorite
                          ? Colors.red
                          : const Color(0xFFBBBBBB),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Flexible(
                child: Text(
                  item.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E),
                    height: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Text(
                '${item.postCount}+ पोस्टर',
                style: const TextStyle(
                  fontSize: 7.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

