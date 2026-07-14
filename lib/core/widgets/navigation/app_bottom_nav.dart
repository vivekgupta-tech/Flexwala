import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class NavItemData {
  final IconData icon;
  final String label;
  const NavItemData({required this.icon, required this.label});
}

/// Global bottom navigation bar — single canonical implementation.
/// Used by every screen. Has: Home | Category | [AI Create center] | Orders | Profile.
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
    NavItemData(icon: Icons.receipt_long_outlined, label: 'Orders'),
    NavItemData(icon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final navItems = items ?? defaultItems;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    // 68px bar height + bottom safe area + small extra lift
    final barHeight = 68.0 + bottomPadding + 8.0;

    return Container(
      height: barHeight + 14, // 14 extra for the raised center button overflow
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // The white bar
          Positioned(
            left: 0,
            right: 0,
            top: 14,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x18000000),
                    blurRadius: 16,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              padding: EdgeInsets.only(bottom: bottomPadding + 4),
              child: Builder(
                builder: (ctx) {
                  final int half = navItems.length ~/ 2;
                  final left = navItems.sublist(0, half);
                  final right = navItems.sublist(half);
                  return Row(
                    children: [
                      for (int i = 0; i < left.length; i++) _navSlot(left[i], i),
                      const SizedBox(width: 72), // gap for center FAB
                      for (int i = 0; i < right.length; i++)
                        _navSlot(right[i], half + i),
                    ],
                  );
                },
              ),
            ),
          ),
          // Center raised button
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                onCenterTap?.call();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: const BoxDecoration(
                      gradient: AppColors.brandGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x4A4A2FBF),
                          blurRadius: 18,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Icon(centerIcon, color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    centerLabel,
                    style: AppTextStyles.navLabelActive.copyWith(
                      color: AppColors.primaryOrange,
                      fontSize: 10,
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
    final bool active = index == currentIndex;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.selectionClick();
            onItemTap?.call(index);
          },
          splashColor: AppColors.primaryPurple.withValues(alpha: 0.08),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    item.icon,
                    size: 22,
                    color: active ? AppColors.navActive : AppColors.navInactive,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.label,
                  style: active
                      ? AppTextStyles.navLabelActive.copyWith(fontSize: 10)
                      : AppTextStyles.navLabel.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
