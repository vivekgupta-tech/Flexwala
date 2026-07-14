import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'bottom_nav.dart';
import 'category_card.dart';

import '../widgets/app_drawer.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const List<CategoryCardData> _categories = [
    CategoryCardData(
      title: 'Business',
      subtitle: 'Promote your\nbusiness & services',
      icon: Icons.work_outline_rounded,
      accentColor: AppColors.businessOrange,
      bgColor: Color(0xFFFFEDD5),
    ),
    CategoryCardData(
      title: 'Online Services',
      subtitle: 'Digital services\nmade easy',
      icon: Icons.language_rounded,
      accentColor: AppColors.primaryPurple,
      bgColor: Color(0xFFEDE9FE),
    ),
    CategoryCardData(
      title: 'Political',
      subtitle: 'Connect with\nyour supporters',
      icon: Icons.account_balance_rounded,
      accentColor: AppColors.politicalBlue,
      bgColor: Color(0xFFDBEAFE),
    ),
    CategoryCardData(
      title: 'Personal',
      subtitle: 'Build your personal\ndigital identity',
      icon: Icons.person_rounded,
      accentColor: AppColors.personalPurple,
      bgColor: Color(0xFFF3E8FF),
    ),
    CategoryCardData(
      title: 'Devotional',
      subtitle: 'Share your faith\n& spirituality',
      icon: Icons.temple_hindu_rounded,
      accentColor: AppColors.devotionalRed,
      bgColor: Color(0xFFFEE2E2),
    ),
    CategoryCardData(
      title: 'Royal',
      subtitle: 'Showcase your\nroyal identity',
      icon: Icons.diamond_outlined,
      accentColor: AppColors.royalYellow,
      bgColor: Color(0xFFFEF3C7),
    ),
    CategoryCardData(
      title: 'Festival',
      subtitle: 'Celebrate festivals\n& special events',
      icon: Icons.celebration_rounded,
      accentColor: AppColors.festivalGreen,
      bgColor: Color(0xFFDCFCE7),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBg,
      drawer: const AppDrawer(),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onItemTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 8),
            _buildTopBar(),
            const SizedBox(height: 20),
            _buildHeroSection(),
            const SizedBox(height: 28),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14,
                crossAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final category = _categories[index];
                return CategoryCard(
                  data: category,
                  onTap: () {
                    if (category.title == 'Business') {
                      Navigator.pushNamed(context, '/business_category');
                    } else if (category.title == 'Online Services') {
                      Navigator.pushNamed(context, '/online_services');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Coming Soon!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Builder(
      builder: (context) => Row(
        children: [
          IconButton(
            icon:
                const Icon(Icons.menu_rounded, size: 24, color: AppColors.textDark),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.change_history_rounded,
                    color: AppColors.politicalBlue, size: 20),
                const SizedBox(width: 4),
                Flexible(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5),
                      children: [
                        TextSpan(
                            text: 'FLEX',
                            style: TextStyle(color: AppColors.textDark)),
                        TextSpan(
                            text: 'WALA',
                            style: TextStyle(color: AppColors.businessOrange)),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications_none_rounded,
                  size: 24, color: AppColors.textDark),
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: AppColors.businessOrange,
                    shape: BoxShape.circle,
                  ),
                  child: const Text('3',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome to Flexwala 👋',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.businessOrange)),
              const SizedBox(height: 4),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                  children: [
                    TextSpan(
                        text: 'Choose Your\n',
                        style: TextStyle(color: Color(0xFF16213E))),
                    TextSpan(
                        text: 'Category ',
                        style: TextStyle(color: AppColors.businessOrange)),
                    TextSpan(text: '✨', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              const Text('Create your digital identity',
                  style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.businessOrange.withOpacity(0.15),
                    AppColors.personalPurple.withOpacity(0.10),
                  ],
                ),
              ),
              child: const Center(
                child: Text('🧑\u200d💼', style: TextStyle(fontSize: 48)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}