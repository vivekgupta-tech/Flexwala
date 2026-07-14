import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:flexify/core/widgets/navigation/app_bottom_nav.dart';
import '../data/home_mock_data.dart';
import 'widgets/home_header.dart';
import 'widgets/greeting_row.dart';
import 'widgets/banner_carousel.dart';
import 'widgets/date_strip.dart';
import 'widgets/templates_section.dart';
import 'widgets/premium_banner.dart';

/// Home screen — matches Image 1 pixel-for-pixel:
/// header, greeting + select-business, promo banner, date strip,
/// today's templates, premium upsell, bottom nav.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: HomeHeader(notificationCount: HomeMockData.notificationCount),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                children: [
                  GreetingRow(userName: HomeMockData.userName),
                  const SizedBox(height: 16),
                  const BannerCarousel(),
                  const SizedBox(height: 22),
                  DateStrip(dates: HomeMockData.dates),
                  const SizedBox(height: 22),
                  TemplatesSection(templates: HomeMockData.templates),
                  const SizedBox(height: 18),
                  const PremiumBanner(),
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
}
