import 'package:flutter/material.dart';
import 'package:flexify/core/theme/app_colors.dart';
import 'package:flexify/core/widgets/navigation/app_bottom_nav.dart';
import 'package:flexify/features/menu/presentation/widgets/app_drawer.dart';
import 'package:flexify/features/menu/presentation/pages/Service_grid_item.dart';

class BusinessCategoryScreen extends StatelessWidget {
  const BusinessCategoryScreen({super.key});

  static final List<ServiceItem> _services = [
    const ServiceItem(title: 'आधार कार्ड', posterCount: '250+ पोस्टर', icon: Icon(Icons.fingerprint, color: Colors.deepOrange, size: 24)),
    const ServiceItem(title: 'PAN कार्ड', posterCount: '180+ पोस्टर', icon: Icon(Icons.badge_outlined, color: Colors.indigo, size: 24)),
    const ServiceItem(title: 'CSC', posterCount: '200+ पोस्टर', icon: Icon(Icons.apartment_rounded, color: Colors.blue, size: 24)),
    const ServiceItem(title: 'आपले सरकार', posterCount: '150+ पोस्टर', icon: Icon(Icons.account_balance, color: Colors.green, size: 24)),
    const ServiceItem(title: 'Setu', posterCount: '120+ पोस्टर', icon: Icon(Icons.hub_rounded, color: Colors.teal, size: 24)),
    const ServiceItem(title: 'आयुष्मान भारत', posterCount: '100+ पोस्टर', icon: Icon(Icons.eco, color: Colors.green, size: 24)),
    const ServiceItem(title: 'वोटर ID', posterCount: '120+ पोस्टर', icon: Icon(Icons.how_to_vote_outlined, color: Colors.indigo, size: 24)),
    const ServiceItem(title: 'पासपोर्ट सेवा', posterCount: '100+ पोस्टर', icon: Icon(Icons.menu_book_rounded, color: Color(0xFF1E3A8A), size: 24)),
    const ServiceItem(title: 'ड्राइविंग लाइसेंस', posterCount: '90+ पोस्टर', icon: Icon(Icons.badge, color: Colors.redAccent, size: 24)),
    const ServiceItem(title: 'राशन कार्ड', posterCount: '80+ पोस्टर', icon: Icon(Icons.rice_bowl_outlined, color: Colors.green, size: 24)),
    const ServiceItem(title: 'जन्म प्रमाणपत्र', posterCount: '80+ पोस्टर', icon: Icon(Icons.child_care, color: Colors.blueAccent, size: 24)),
    const ServiceItem(title: 'जाति प्रमाणपत्र', posterCount: '70+ पोस्टर', icon: Icon(Icons.description_outlined, color: Colors.brown, size: 24)),
    const ServiceItem(title: 'आय प्रमाणपत्र', posterCount: '70+ पोस्टर', icon: Icon(Icons.currency_rupee, color: Colors.blue, size: 24)),
    const ServiceItem(title: 'निवास प्रमाणपत्र', posterCount: '60+ पोस्टर', icon: Icon(Icons.home_outlined, color: Colors.indigo, size: 24)),
    const ServiceItem(title: 'उद्योग पंजीकरण', posterCount: '60+ पोस्टर', icon: Icon(Icons.factory_outlined, color: Colors.grey, size: 24)),
  ];

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Coming Soon!'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColors.primaryPurple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: _buildTopBar(context),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 8),
                  _buildSearchRow(),
                  const SizedBox(height: 16),
                  _buildOnlineServicesBanner(),
                  const SizedBox(height: 20),
                  _buildSectionHeader(),
                  const SizedBox(height: 14),
                  _buildServiceGrid(context),
                  const SizedBox(height: 16),
                  _buildBottomBanner(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onCenterTap: () => Navigator.pushReplacementNamed(context, '/home'),
        onItemTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/category');
          }
        },
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: 26, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFF97316), Color(0xFFDB2777)],
                ).createShader(bounds),
                child: const Text(
                  'Flexwalá',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              const Text(
                'डिजिटल ओळख + ब्रँडिंग प्लॅटफॉर्म',
                style: TextStyle(fontSize: 10, color: AppColors.textGrey, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        _buildIconWithBadge(Icons.notifications_none_rounded, '3'),
      ],
    );
  }

  Widget _buildIconWithBadge(IconData icon, String badge) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Icon(icon, size: 20, color: AppColors.textDark),
        ),
        Positioned(
          top: -2,
          right: -2,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              badge,
              style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.searchBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: AppColors.textGrey, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'आप आज काय बनाना चाहते हैं?',
              style: TextStyle(color: AppColors.textGrey, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineServicesBanner() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.bannerBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    colors: [AppColors.bannerStart, AppColors.bannerEnd],
                  ),
                ),
                child: const Icon(Icons.language_rounded, color: Colors.white, size: 26),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Online Services',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                    SizedBox(height: 2),
                    Text('डिजिटल सेवाएं, आसान समाधान', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                  ],
                ),
              ),
              const Icon(Icons.laptop_mac_rounded,
                  size: 40, color: AppColors.primaryPurple),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatItem(icon: Icons.grid_view_rounded, value: '50+', label: 'Services'),
              _StatItem(icon: Icons.image_outlined, value: '5000+', label: 'Posters'),
              _StatItem(icon: Icons.download_rounded, value: '10K+', label: 'Downloads'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('सेवा चुनें', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark)),
        SizedBox(height: 2),
        Text('नीचे दी गई सेवाओं में से चुनें', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
      ],
    );
  }

  Widget _buildServiceGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return ServiceGridItem(
          item: _services[index],
          onTap: () => _showComingSoon(context),
        );
      },
    );
  }

  Widget _buildBottomBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bannerBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.lock_outline_rounded, color: AppColors.primaryPurple),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('सभी सेवाओं के पोस्टर', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    Text('प्रोफेशनल पोस्टर डिजाइन डाउनलोड करें', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showComingSoon(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('लेटेस्ट पोस्टर देखें', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: AppColors.primaryPurple),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textDark)),
            Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textGrey, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}
