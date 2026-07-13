import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Bottom navigation bar shared by Home and Category screens.
/// [currentIndex]: 0 = Category, 1 = Home, 2 = Profile
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavItem(
              icon: Icons.home_rounded,
              label: 'Home',
              isActive: currentIndex == 0,
              onTap: () {
                if (currentIndex != 0) Navigator.pushReplacementNamed(context, '/menu');
              },
            ),
            _NavItem(
              icon: Icons.grid_view_rounded,
              label: 'Categories',
              isActive: currentIndex == 1,
              onTap: () {
                if (currentIndex != 1) Navigator.pushReplacementNamed(context, '/category');
              },
            ),
            _NavItem(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              isActive: currentIndex == 2,
              onTap: () {
                if (currentIndex != 2) Navigator.pushReplacementNamed(context, '/poster_detail');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isCenterHome;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.isCenterHome = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.navActive : AppColors.navInactive;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCenterHome)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isActive
                      ? const LinearGradient(
                    colors: [Color(0xFFF97316), Color(0xFFDB2777)],
                  )
                      : null,
                  color: isActive ? null : Colors.transparent,
                ),
                child: Icon(
                  icon,
                  color: isActive ? Colors.white : color,
                  size: 22,
                ),
              )
            else
              Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}