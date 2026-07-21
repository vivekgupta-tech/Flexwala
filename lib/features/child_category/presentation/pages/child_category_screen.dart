import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../menu/presentation/pages/category_card.dart';
import '../bloc/child_category_bloc.dart';
import '../bloc/child_category_event.dart';
import '../bloc/child_category_state.dart';

class ChildCategoryScreen extends StatelessWidget {
  final String subCategoryId;

  const ChildCategoryScreen({super.key, required this.subCategoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Child Categories',
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ChildCategoryBloc, ChildCategoryState>(
        builder: (context, state) {
          if (state is ChildCategoryLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple));
          } else if (state is ChildCategoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () => context.read<ChildCategoryBloc>().add(FetchChildCategories()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is ChildCategoryLoaded) {
            final filteredList = state.childCategories
                .where((item) => item.subCategoryId == subCategoryId)
                .toList();

            if (filteredList.isEmpty) {
              return const Center(child: Text('No Child Categories found.'));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14,
                crossAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final item = filteredList[index];
                
                final List<Color> accentColors = [
                  AppColors.businessOrange,
                  AppColors.primaryPurple,
                  AppColors.politicalBlue,
                  AppColors.personalPurple,
                  AppColors.devotionalRed,
                ];
                final List<Color> bgColors = [
                  const Color(0xFFFFEDD5),
                  const Color(0xFFEDE9FE),
                  const Color(0xFFDBEAFE),
                  const Color(0xFFF3E8FF),
                  const Color(0xFFFEE2E2),
                ];

                final colorIndex = index % accentColors.length;
                final String displayTitle = item.title.split(' ').first;

                return CategoryCard(
                  data: CategoryCardData(
                    title: displayTitle,
                    subtitle: item.title,
                    icon: Icons.grid_view_rounded,
                    accentColor: accentColors[colorIndex],
                    bgColor: bgColors[colorIndex],
                    imageUrl: item.imageUrl,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.banners,
                      arguments: {
                        'categoryId': item.categoryId,
                        'childId': item.id,
                        'title': item.title,
                      },
                    );
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
