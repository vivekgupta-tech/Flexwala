import 'package:flutter/material.dart';
import 'package:flexwala/core/theme/app_colors.dart';
import 'package:flexwala/core/widgets/navigation/app_bottom_nav.dart';
import 'package:flexwala/core/widgets/common_widgets.dart';

import 'package:flexwala/features/menu/presentation/widgets/app_drawer.dart';

class ServiceItem {
  final String title;
  final String posterCount;
  final Widget icon;

  ServiceItem({
    required this.title,
    required this.posterCount,
    required this.icon,
  });
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  static final List<ServiceItem> _services = [
    ServiceItem(
      title: 'आधार कार्ड',
      posterCount: '250+ पोस्टर',
      icon: const Icon(Icons.fingerprint, color: Colors.deepOrange, size: 30),
    ),
    ServiceItem(
      title: 'PAN कार्ड',
      posterCount: '180+ पोस्टर',
      icon: const Icon(Icons.badge_outlined, color: Colors.indigo, size: 28),
    ),
    ServiceItem(
      title: 'CSC',
      posterCount: '200+ पोस्टर',
      icon: const Icon(Icons.apartment_rounded, color: Colors.blue, size: 28),
    ),
    ServiceItem(
      title: 'आपले सरकार',
      posterCount: '150+ पोस्टर',
      icon: const Icon(Icons.account_balance, color: Colors.green, size: 28),
    ),
    ServiceItem(
      title: 'Setu',
      posterCount: '120+ पोस्टर',
      icon: const Icon(Icons.hub_rounded, color: Colors.teal, size: 28),
    ),
    ServiceItem(
      title: 'आयुष्मान भारत',
      posterCount: '100+ पोस्टर',
      icon: const Icon(Icons.eco, color: Colors.green, size: 28),
    ),
    ServiceItem(
      title: 'वोटर ID',
      posterCount: '120+ पोस्टर',
      icon: const Icon(Icons.how_to_vote_outlined,
          color: Colors.indigo, size: 28),
    ),
    ServiceItem(
      title: 'पासपोर्ट सेवा',
      posterCount: '100+ पोस्टर',
      icon: const Icon(Icons.menu_book_rounded,
          color: Color(0xFF1E3A8A), size: 28),
    ),
    ServiceItem(
      title: 'ड्राइविंग लाइसेंस',
      posterCount: '90+ पोस्टर',
      icon: const Icon(Icons.badge, color: Colors.redAccent, size: 28),
    ),
    ServiceItem(
      title: 'राशन कार्ड',
      posterCount: '80+ पोस्टर',
      icon: const Icon(Icons.rice_bowl_outlined,
          color: Colors.green, size: 28),
    ),
    ServiceItem(
      title: 'जन्म प्रमाणपत्र',
      posterCount: '80+ पोस्टर',
      icon: const Icon(Icons.child_care, color: Colors.blueAccent, size: 28),
    ),
    ServiceItem(
      title: 'जाति प्रमाणपत्र',
      posterCount: '70+ पोस्टर',
      icon: const Icon(Icons.description_outlined,
          color: Colors.brown, size: 28),
    ),
    ServiceItem(
      title: 'आय प्रमाणपत्र',
      posterCount: '70+ पोस्टर',
      icon: const Icon(Icons.currency_rupee, color: Colors.blue, size: 28),
    ),
    ServiceItem(
      title: 'निवास प्रमाणपत्र',
      posterCount: '60+ पोस्टर',
      icon: const Icon(Icons.home_outlined, color: Colors.indigo, size: 28),
    ),
    ServiceItem(
      title: 'उद्योग पंजीकरण',
      posterCount: '60+ पोस्टर',
      icon: const Icon(Icons.factory_outlined, color: Colors.grey, size: 28),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onItemTap: (index) {
           if (index == 0) {
             Navigator.pushReplacementNamed(context, '/home');
           } else if (index == 1) {
             Navigator.pushNamed(context, '/category');
           }
        },
        onCenterTap: () => Navigator.pushReplacementNamed(context, '/home'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 8),
            _buildTopBar(),
            const SizedBox(height: 16),
            _buildSearchRow(),
            const SizedBox(height: 16),
            _buildOnlineServicesBanner(),
            const SizedBox(height: 20),
            _buildSectionHeader(),
            const SizedBox(height: 14),
            _buildServiceGrid(),
            const SizedBox(height: 16),
            _buildBottomBanner(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // --- Top App Bar -----------------------------------------------------
  Widget _buildTopBar() {
    return Builder(
      builder: (context) => Row(
        children: [
          IconButton(
            icon:
                const Icon(Icons.menu_rounded, size: 26, color: AppColors.textDark),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [
                        Colors.orange,
                        Colors.pink,
                        Colors.purple,
                        Colors.blue,
                        Colors.orange,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text('🙂', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 8),
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
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Text(
                        'डिजिटल ओळख + ब्रँडिंग प्लॅटफॉर्म',
                        style: TextStyle(fontSize: 8, color: AppColors.textGrey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          _buildSubscriptionPill(),
          const SizedBox(width: 4),
          _buildIconWithBadge(Icons.notifications_none_rounded, '3'),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: const Icon(Icons.account_balance_wallet_outlined,
                size: 16, color: AppColors.primaryPurple),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.emoji_events, size: 14, color: Colors.amber),
          SizedBox(width: 4),
          Text('Sub',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
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
          child: Icon(icon, size: 18, color: AppColors.textDark),
        ),
        Positioned(
          top: -2,
          right: -2,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              badge,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  // --- Search + Filter ---------------------------------------------------
  Widget _buildSearchRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.searchBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: AppColors.textGrey, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'आप आज काय बनाना चाहते हैं?',
                    style: TextStyle(color: AppColors.textGrey, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: const Row(
            children: [
              Icon(Icons.tune_rounded, size: 16, color: AppColors.textDark),
              SizedBox(width: 4),
              Text('Filter',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }

  // --- Online Services Banner ---------------------------------------------
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
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    colors: [AppColors.bannerStart, AppColors.bannerEnd],
                  ),
                ),
                child: const Icon(Icons.language_rounded,
                    color: Colors.white, size: 26),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Online Services',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark)),
                    SizedBox(height: 2),
                    Text('डिजिटल सेवाएं, आसान समाधान',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.textGrey)),
                  ],
                ),
              ),
              const Icon(Icons.laptop_mac_rounded,
                  size: 44, color: AppColors.primaryPurple),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              _BannerStat(
                  icon: Icons.grid_view_rounded, value: '50+', label: 'Services'),
              SizedBox(width: 22),
              _BannerStat(
                  icon: Icons.image_outlined, value: '5000+', label: 'Posters'),
              SizedBox(width: 22),
              _BannerStat(
                  icon: Icons.download_rounded,
                  value: '10K+',
                  label: 'Downloads'),
            ],
          ),
        ],
      ),
    );
  }

  // --- Section Header ------------------------------------------------------
  Widget _buildSectionHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('सेवा चुनें',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark)),
        SizedBox(height: 2),
        Text('नीचे दी गई सेवाओं में से चुनें',
            style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
      ],
    );
  }

  // --- Services Grid ---------------------------------------------------
  Widget _buildServiceGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 8,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) =>
          ServiceGridItem(item: _services[index]),
    );
  }

  // --- Bottom Poster Banner -----------------------------------------------
  Widget _buildBottomBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.lock_outline_rounded,
                    color: AppColors.primaryPurple),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('सभी सेवाओं के पोस्टर',
                        style: TextStyle(
                            fontSize: 13.5, fontWeight: FontWeight.w700)),
                    SizedBox(height: 2),
                    Text('अपने बिजनेस के लिए प्रोफेशनल पोस्टर डाउनलोड करें',
                        style: TextStyle(
                            fontSize: 10.5, color: AppColors.textGrey)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/poster_detail');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('लेटेस्ट पोस्टर देखें',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700)),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_rounded, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceGridItem extends StatelessWidget {
  final ServiceItem item;
  const ServiceGridItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Center(child: item.icon),
        ),
        const SizedBox(height: 4),
        Text(
          item.title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          item.posterCount,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 7, color: AppColors.textGrey),
        ),
      ],
    );
  }
}

class _BannerStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _BannerStat(
      {required this.icon, required this.value, required this.label});

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
            Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark)),
            Text(label,
                style: const TextStyle(
                    fontSize: 10, color: AppColors.textGrey)),
          ],
        ),
      ],
    );
  }
}

