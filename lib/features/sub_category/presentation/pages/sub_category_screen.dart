import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/navigation/app_bottom_nav.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../menu/presentation/pages/category_card.dart';
import '../../../menu/presentation/widgets/app_drawer.dart';
import '../bloc/sub_category_bloc.dart';

class SubCategoryScreen extends StatelessWidget {
  final String categoryId;

  const SubCategoryScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBg,
      drawer: const AppDrawer(),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onItemTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, AppRoutes.profile);
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, AppRoutes.category);
          }
        },
      ),
      body: SafeArea(
        child: BlocBuilder<SubCategoryBloc, SubCategoryState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 8),
                _buildTopBar(context),
                const SizedBox(height: 20),
                _buildHeroSection(),
                const SizedBox(height: 28),
                if (state is SubCategoryLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: CircularProgressIndicator(color: AppColors.primaryPurple),
                    ),
                  )
                else if (state is SubCategoryError)
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Text('Error: ${state.message}'),
                        ElevatedButton(
                          onPressed: () => context.read<SubCategoryBloc>().add(FetchSubCategories()),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                else if (state is SubCategoryLoaded)
                  _buildSubCategoryGrid(context, state),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSubCategoryGrid(BuildContext context, SubCategoryLoaded state) {
    final filteredList = state.subCategories
        .where((sub) => sub.categoryId == categoryId)
        .toList();

    if (filteredList.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Text('No sub-categories found for this category.',
              style: TextStyle(color: AppColors.textGrey)),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14,
        crossAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final sub = filteredList[index];
        
        final List<Color> accentColors = [
          AppColors.businessOrange,
          AppColors.primaryPurple,
          AppColors.politicalBlue,
          AppColors.personalPurple,
          AppColors.devotionalRed,
          AppColors.royalYellow,
          AppColors.festivalGreen,
        ];
        final List<Color> bgColors = [
          const Color(0xFFFFEDD5),
          const Color(0xFFEDE9FE),
          const Color(0xFFDBEAFE),
          const Color(0xFFF3E8FF),
          const Color(0xFFFEE2E2),
          const Color(0xFFFEF3C7),
          const Color(0xFFDCFCE7),
        ];
        final List<IconData> icons = [
          Icons.category_rounded,
          Icons.layers_rounded,
          Icons.auto_awesome_mosaic_rounded,
          Icons.dashboard_customize_rounded,
          Icons.style_rounded,
        ];

        final colorIndex = index % accentColors.length;
        
        // second word is removed
        final String displayTitle = sub.title.split(' ').first;

        return CategoryCard(
          data: CategoryCardData(
            title: displayTitle,
            subtitle: sub.title,
            icon: icons[index % icons.length],
            accentColor: accentColors[colorIndex],
            bgColor: bgColors[colorIndex],
            imageUrl: sub.imageUrl,
          ),
          onTap: () {
            Navigator.pushNamed(
              context, 
              AppRoutes.childCategory, 
              arguments: sub.id
            );
          },
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Sub Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
          ),
        ),
        const SizedBox(width: 40), 
      ],
    );
  }

  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
            children: [
              TextSpan(
                  text: 'Pick Your\n',
                  style: TextStyle(color: Color(0xFF16213E))),
              TextSpan(
                  text: 'Sub-Category ',
                  style: TextStyle(color: AppColors.businessOrange)),
              TextSpan(text: '🎯', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Text('Refine your search for the perfect design',
            style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
      ],
    );
  }
}
