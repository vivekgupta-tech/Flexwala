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
import '../../menu/presentation/widgets/app_drawer.dart';

/// Home screen — the default landing screen.
class HomePageOld extends StatelessWidget {
  const HomePageOld({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Builder(
              builder: (scaffoldCtx) => Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: HomeHeader(
                  notificationCount: HomeMockData.notificationCount,
                  onMenuTap: () => Scaffold.of(scaffoldCtx).openDrawer(),
                  onBellTap: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Notifications — Coming Soon!'),
                        backgroundColor: AppColors.primaryPurple,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                physics: const BouncingScrollPhysics(),
                children: [
                  GreetingRow(userName: HomeMockData.userName),
                  const SizedBox(height: 16),
                  BannerCarousel(
                    onExploreTap: () => Navigator.pushNamed(context, '/category'),
                  ),
                  const SizedBox(height: 22),
                  DateStrip(dates: HomeMockData.dates),
                  const SizedBox(height: 22),
                  TemplatesSection(
                    templates: HomeMockData.templates,
                    onSeeAllTap: () => Navigator.pushNamed(context, '/category'),
                  ),
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

