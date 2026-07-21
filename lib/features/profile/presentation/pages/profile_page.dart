import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/navigation/app_router.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../../../../core/widgets/navigation/app_bottom_nav.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple));
          } else if (state is ProfileLoaded) {
            final profile = state.profile;
            return Column(
              children: [
                // Fixed Header Area (Non-scrollable)
                _buildHeader(profile),
                
                // Scrollable details area
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        _buildSectionTitle('Personal Information'),
                        _buildInfoSection(profile),
                        const SizedBox(height: 20),
                        _buildSectionTitle('Business Details'),
                        _buildBusinessSection(profile),
                        const SizedBox(height: 30),
                        _buildLogoutButton(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<ProfileBloc>().add(FetchProfile()),
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 3,
        onItemTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, AppRoutes.home);
          if (index == 1) Navigator.pushReplacementNamed(context, AppRoutes.category);
        },
      ),
    );
  }

  Widget _buildHeader(dynamic profile) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: AppColors.brandGradientDiagonal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.pageTitle.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 75),
          ],
        ),
        Positioned(
          bottom: 0,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.iconBgPurple,
                  backgroundImage: profile.customerImage != null && profile.customerImage.isNotEmpty
                      ? NetworkImage('https://105106.in/flexwala/${profile.customerImage}')
                      : null,
                  child: profile.customerImage == null || profile.customerImage.isEmpty
                      ? const Icon(Icons.person, size: 65, color: AppColors.primaryPurple)
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                profile.fullName,
                style: AppTextStyles.greeting.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '+91 ${profile.mobile}',
                  style: AppTextStyles.bannerCta.copyWith(color: AppColors.primaryOrange, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.primaryPurple,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(dynamic profile) {
    return _buildCard([
      _buildInfoRow(Icons.email_outlined, 'Email Address', profile.email ?? 'Not provided', isLast: true),
    ]);
  }

  Widget _buildBusinessSection(dynamic profile) {
    return _buildCard([
      _buildInfoRow(Icons.business_center_outlined, 'Business Name', profile.businessName ?? 'N/A'),
      _buildInfoRow(Icons.phone_android_rounded, 'Business Mobile', profile.businessMobile ?? 'N/A'),
      _buildInfoRow(Icons.chat_bubble_outline_rounded, 'WhatsApp Number', profile.businessWhatsappNo ?? 'N/A'),
      _buildInfoRow(Icons.location_on_outlined, 'Business Address', profile.businessAddress ?? 'N/A'),
      _buildInfoRow(Icons.badge_outlined, 'PAN Card', profile.businessPan ?? 'N/A'),
      _buildInfoRow(Icons.fingerprint_rounded, 'Aadhar Number', profile.businessAdharNo ?? 'N/A', isLast: true),
    ]);
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primaryPurple, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.bannerBody.copyWith(fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: AppTextStyles.sectionTitle.copyWith(
                        fontSize: 14,
                        color: AppColors.textPrimary.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Divider(height: 1, color: AppColors.dividerColor.withOpacity(0.5)),
          ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // TODO: Implement logout logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            elevation: 0,
            side: BorderSide(color: Colors.red.shade100, width: 1.5),
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, size: 22),
              SizedBox(width: 10),
              Text('Logout Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
