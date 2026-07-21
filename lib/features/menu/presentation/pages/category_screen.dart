import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/navigation/app_bottom_nav.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/category_bloc.dart';
import 'category_card.dart';
import '../widgets/app_drawer.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoryBloc>()..add(FetchCategories()),
      child: Scaffold(
        backgroundColor: AppColors.pageBg,
        drawer: const AppDrawer(),
        bottomNavigationBar: AppBottomNav(
          currentIndex: 1,
          onItemTap: (index) {
            if (index == 0) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            } else if (index == 3) {
              Navigator.pushReplacementNamed(context, AppRoutes.profile);
            }
          },
        ),
        body: SafeArea(
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 8),
                  _buildTopBar(context),
                  const SizedBox(height: 20),
                  _buildHeroSection(),
                  const SizedBox(height: 28),
                  if (state is CategoryLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: CircularProgressIndicator(color: AppColors.primaryPurple),
                      ),
                    )
                  else if (state is CategoryError)
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          Text('Error: ${state.message}'),
                          ElevatedButton(
                            onPressed: () => context.read<CategoryBloc>().add(FetchCategories()),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  else if (state is CategoryLoaded)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.categories.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        // Assigning colors dynamically based on index for variety
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
                          Icons.work_outline_rounded,
                          Icons.language_rounded,
                          Icons.account_balance_rounded,
                          Icons.person_rounded,
                          Icons.temple_hindu_rounded,
                          Icons.diamond_outlined,
                          Icons.celebration_rounded,
                        ];

                        final colorIndex = index % accentColors.length;

                        // second word is removed
                        final String displayTitle = category.title.split(' ').first;

                        return CategoryCard(
                          data: CategoryCardData(
                            title: displayTitle,
                            subtitle: category.title,
                            icon: icons[index % icons.length],
                            accentColor: accentColors[colorIndex],
                            bgColor: bgColors[colorIndex],
                            imageUrl: category.imageUrl,
                          ),
                          onTap: () {
                            if (category.title.toLowerCase().contains('business')) {
                               Navigator.pushNamed(context, AppRoutes.businessCategory);
                            } else {
                               Navigator.pushNamed(
                                 context, 
                                 AppRoutes.template, 
                                 arguments: category.title
                               );
                            }
                          },
                        );
                      },
                    ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.menu_rounded, size: 24, color: AppColors.textDark),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.change_history_rounded,
                  color: AppColors.politicalBlue, size: 20),
              const SizedBox(width: 4),
              Flexible(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5),
                    children: [
                      TextSpan(
                          text: 'FLEX',
                          style: TextStyle(color: AppColors.textDark)),
                      TextSpan(
                          text: 'WALA',
                          style: TextStyle(color: AppColors.businessOrange)),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.notifications_none_rounded,
                size: 24, color: AppColors.textDark),
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppColors.businessOrange,
                  shape: BoxShape.circle,
                ),
                child: const Text('3',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome to Flexwala 👋',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.businessOrange)),
              const SizedBox(height: 4),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                  children: [
                    TextSpan(
                        text: 'Choose Your\n',
                        style: TextStyle(color: Color(0xFF16213E))),
                    TextSpan(
                        text: 'Category ',
                        style: TextStyle(color: AppColors.businessOrange)),
                    TextSpan(text: '✨', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              const Text('Create your digital identity',
                  style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.businessOrange.withOpacity(0.15),
                    AppColors.personalPurple.withOpacity(0.10),
                  ],
                ),
              ),
              child: const Center(
                child: Text('🧑\u200d💼', style: TextStyle(fontSize: 48)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
