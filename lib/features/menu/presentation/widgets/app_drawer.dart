import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildPosterPreview(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                children: [
                  _DrawerItem(
                    icon: Icons.workspace_premium_rounded,
                    iconColor: const Color(0xFFF97316),
                    iconBgColor: const Color(0xFFFFE8D6),
                    title: 'Subscription',
                    subtitle: 'Manage your premium membership',
                    onTap: () {},
                  ),
                  _DrawerItem(
                    icon: Icons.auto_awesome_rounded,
                    iconGradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
                    ),
                    iconBgColor: const Color(0xFFEEF2FF),
                    title: 'Custom Design Order',
                    subtitle: 'Order custom templates, frames, political footers, business profiles & more',
                    isHighlighted: true,
                    onTap: () {},
                  ),
                  _DrawerItem(
                    icon: Icons.image_outlined,
                    iconColor: const Color(0xFFF59E0B),
                    iconBgColor: const Color(0xFFFFF7ED),
                    title: 'My Gallery',
                    subtitle: 'View all your saved designs',
                    onTap: () {},
                  ),
                  _DrawerItem(
                    icon: Icons.headset_mic_outlined,
                    iconColor: const Color(0xFF3B82F6),
                    iconBgColor: const Color(0xFFEFF6FF),
                    title: 'Help & Support',
                    subtitle: 'Get assistance and contact support',
                    onTap: () {},
                  ),
                  _DrawerItem(
                    icon: Icons.assignment_outlined,
                    iconColor: const Color(0xFF8B5CF6),
                    iconBgColor: const Color(0xFFF5F3FF),
                    title: 'Terms & Conditions',
                    subtitle: 'Read our service terms',
                    onTap: () {},
                  ),
                  _DrawerItem(
                    icon: Icons.shield_outlined,
                    iconColor: const Color(0xFF10B981),
                    iconBgColor: const Color(0xFFECFDF5),
                    title: 'Privacy & Return Policy',
                    subtitle: 'Learn about privacy and refund rules',
                    onTap: () {},
                  ),
                  _DrawerItem(
                    icon: Icons.share_outlined,
                    iconColor: const Color(0xFFEF4444),
                    iconBgColor: const Color(0xFFFEF2F2),
                    title: 'Share App',
                    subtitle: 'Invite friends and earn referrals',
                    onTap: () {},
                  ),
                  _DrawerItem(
                    icon: Icons.logout_rounded,
                    iconColor: const Color(0xFFEF4444),
                    iconBgColor: const Color(0xFFFEF2F2),
                    title: 'Log Out',
                    titleColor: const Color(0xFFEF4444),
                    subtitle: 'Sign out from your account',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                      children: [
                        TextSpan(text: 'Flex', style: TextStyle(color: Color(0xFFF97316))),
                        TextSpan(text: 'walá', style: TextStyle(color: Color(0xFF1E3A8A))),
                      ],
                    ),
                  ),
                  const Text(
                    'Digital Identity + Branding Platform',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.close, size: 20, color: Colors.black87),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFFE8D6), width: 2),
                ),
                child: const CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=rana'),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rana Udaysingh',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE8D6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.workspace_premium_rounded, size: 14, color: Color(0xFFF97316)),
                        SizedBox(width: 4),
                        Text(
                          'Premium Member',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF97316),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPosterPreview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1626785774573-4b799315345d?auto=format&fit=crop&q=80&w=500',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Continue Editing',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Business Poster #124',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF97316),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Resume',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.verified_user_outlined, size: 16, color: Color(0xFF3B82F6)),
          const SizedBox(width: 8),
          Text(
            '100% Secure • Trusted by 1M+ Users',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color iconBgColor;
  final Gradient? iconGradient;
  final bool isHighlighted;
  final Color? titleColor;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
    required this.iconBgColor,
    this.iconGradient,
    this.isHighlighted = false,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHighlighted ? const Color(0xFFDBEAFE) : Colors.grey.shade100,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: isHighlighted ? const Color(0xFFF8FAFF) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: iconGradient != null
                      ? ShaderMask(
                          shaderCallback: (bounds) => iconGradient!.createShader(bounds),
                          child: Icon(icon, color: Colors.white, size: 24),
                        )
                      : Icon(icon, color: iconColor ?? Colors.grey, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: titleColor ?? const Color(0xFF1A1A2E),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

