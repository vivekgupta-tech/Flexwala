import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/navigation/app_bottom_nav.dart';
import '../../home/presentation/widgets/premium_banner.dart';
import '../data/business_category_mock_data.dart';
import 'widgets/category_header.dart';
import 'widgets/category_search_bar.dart';
import 'widgets/category_breadcrumb.dart';
import 'widgets/category_title_block.dart';
import 'widgets/category_grid_tile.dart';

/// Business Category screen — matches Image 2 pixel-for-pixel:
/// header, search + filter, breadcrumb, title block, 5x4 category grid,
/// premium upsell, bottom nav (कॅटेगरी active).
class BusinessCategoryPage extends StatelessWidget {
  const BusinessCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBg,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: CategoryHeader(notificationCount: 3),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                children: [
                  const CategorySearchBar(),
                  const SizedBox(height: 14),
                  const CategoryBreadcrumb(
                    trail: ['सर्व कॅटेगरी', 'Business'],
                  ),
                  const SizedBox(height: 16),
                  const CategoryTitleBlock(
                    title: 'Business',
                    subtitle: 'आपल्या व्यवसासाठी योग्य कॅटेगरी निवडा',
                    icon: Icons.storefront_outlined,
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: BusinessCategoryMockData.categories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.68,
                    ),
                    itemBuilder: (context, index) {
                      final item = BusinessCategoryMockData.categories[index];
                      return CategoryGridTile(item: item);
                    },
                  ),
                  const SizedBox(height: 18),
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
        items: const [
          NavItemData(icon: Icons.grid_view_rounded, label: 'कॅटेगरी'),
          NavItemData(icon: Icons.person_outline_rounded, label: 'प्रोफाइल'),
        ],
        centerLabel: 'होम',
        centerIcon: Icons.home_rounded,
        currentIndex: 0,
        onCenterTap: () => Navigator.pushReplacementNamed(context, '/home'),
        onItemTap: (index) {
          if (index == 0) {
             Navigator.pushNamed(context, '/category');
          }
        },
      ),
    );
  }
}
