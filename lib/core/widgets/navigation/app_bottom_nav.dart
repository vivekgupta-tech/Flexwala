import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class NavItemData {
  final IconData icon;
  final String label;
  const NavItemData({required this.icon, required this.label});
}

class AppBottomNav extends StatelessWidget {
  final List<NavItemData>? items;
  final int currentIndex;
  final String centerLabel;
  final IconData centerIcon;
  final ValueChanged<int>? onItemTap;
  final VoidCallback? onCenterTap;

  const AppBottomNav({
    super.key,
    this.items,
    required this.currentIndex,
    this.centerLabel = 'AI Create',
    this.centerIcon = Icons.add,
    this.onItemTap,
    this.onCenterTap,
  });

  static const List<NavItemData> defaultItems = [
    NavItemData(icon: Icons.home_rounded, label: 'Home'),
    NavItemData(icon: Icons.grid_view_rounded, label: 'Category'),
    NavItemData(icon: Icons.notifications_none_rounded, label: 'Orders'),
    NavItemData(icon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final navItems = items ?? defaultItems;
    return SizedBox(
      height: 82,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 14,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 12,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Builder(
                builder: (context) {
                  final int half = navItems.length ~/ 2;
                  final left = navItems.sublist(0, half);
                  final right = navItems.sublist(half);
                  return Row(
                    children: [
                      for (int i = 0; i < left.length; i++) _navSlot(left[i], i),
                      const SizedBox(width: 64),
                      for (int i = 0; i < right.length; i++)
                        _navSlot(right[i], half + i),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: onCenterTap,
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      gradient: AppColors.brandGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x334A2FBF),
                          blurRadius: 14,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Icon(centerIcon, color: Colors.white, size: 26),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    centerLabel,
                    style: AppTextStyles.navLabelActive.copyWith(
                      color: AppColors.primaryOrange,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navSlot(NavItemData item, int index) {
    if (item.label.isEmpty) return const Expanded(child: SizedBox());
    final bool active = index == currentIndex;
    return Expanded(
      child: InkWell(
        onTap: () => onItemTap?.call(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 22,
              color: active ? AppColors.navActive : AppColors.navInactive,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: active ? AppTextStyles.navLabelActive : AppTextStyles.navLabel,
            ),
          ],
        ),
      ),
    );
  }
}
