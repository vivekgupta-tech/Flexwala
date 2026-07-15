import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'package:flexwala/core/widgets/navigation/app_bottom_nav.dart';
import 'widgets/banner_carousel.dart';
import 'widgets/date_strip.dart';
import 'widgets/templates_section.dart';
import '../domain/date_item.dart';
import '../domain/template_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for the new sections
    final mockDates = [
      const DateItem(weekday: 'MON', day: '15', month: 'JUL'),
      const DateItem(weekday: 'TUE', day: '16', month: 'JUL'),
      const DateItem(weekday: 'WED', day: '17', month: 'JUL', isToday: true),
      const DateItem(weekday: 'THU', day: '18', month: 'JUL'),
      const DateItem(weekday: 'FRI', day: '19', month: 'JUL'),
      const DateItem(weekday: 'SAT', day: '20', month: 'JUL'),
    ];

    final mockTemplates = [
      const TemplateItem(
        id: '1',
        title: 'FITNESS\nTRAINING',
        subtitle: 'Start your journey\ntowards health',
        phone: '9876543210',
        backgroundColor: Color(0xFFE53935),
        icon: Icons.fitness_center,
        isFavorite: true,
      ),
      const TemplateItem(
        id: '2',
        title: 'BUSINESS\nEXPO 2024',
        subtitle: 'Connect with\nindustry leaders',
        phone: '9123456789',
        backgroundColor: AppColors.primaryPurple,
        icon: Icons.rocket_launch,
      ),
      const TemplateItem(
        id: '3',
        title: 'HEALTHY\nLIVING',
        subtitle: 'Eat fresh and\nstay active',
        phone: '8887776665',
        backgroundColor: Color(0xFF43A047),
        icon: Icons.eco,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 16),
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  const BannerCarousel(),
                  const SizedBox(height: 24),
                  DateStrip(dates: mockDates),
                  const SizedBox(height: 24),
                  TemplatesSection(templates: mockTemplates),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Explore Categories'),
                  const SizedBox(height: 12),
                  _buildCategoryList(),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Trending Templates'),
                  const SizedBox(height: 12),
                  // Placeholder for Trending
                  Container(
                    height: 160,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: const Center(
                      child: Text(
                        'Trending Content Coming Soon',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 0,
        onItemTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/category');
          }
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome to', style: AppTextStyles.bannerEyebrow),
              Text('Flexwala', style: AppTextStyles.pageTitle),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey, size: 20),
          const SizedBox(width: 12),
          Text(
            'Search for templates...',
            style: AppTextStyles.bannerBody.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.sectionTitle),
        Text('See All', style: AppTextStyles.sectionAction),
      ],
    );
  }

  Widget _buildCategoryList() {
    final categories = [
      {'name': 'Business', 'icon': Icons.business_center_outlined},
      {'name': 'Festival', 'icon': Icons.celebration_outlined},
      {'name': 'Birthday', 'icon': Icons.cake_outlined},
      {'name': 'Political', 'icon': Icons.how_to_reg_outlined},
    ];

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  categories[index]['icon'] as IconData,
                  color: AppColors.primaryPurple,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                categories[index]['name'] as String,
                style: AppTextStyles.categoryName.copyWith(fontSize: 11),
              ),
            ],
          );
        },
      ),
    );
  }
}

