import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../editor/domain/entities/template.dart';
import '../../../template/editor_page.dart';
import '../bloc/banner_bloc.dart';
import '../bloc/banner_event.dart';
import '../bloc/banner_state.dart';

class BannersScreen extends StatelessWidget {
  final String categoryId;
  final String childId;
  final String title;

  const BannersScreen({
    super.key,
    required this.categoryId,
    required this.childId,
    required this.title,
  });

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
        title: Text(
          title,
          style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<BannerBloc, BannerState>(
        builder: (context, state) {
          if (state is BannerLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple));
          } else if (state is BannerError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () => context.read<BannerBloc>().add(
                          FetchBannerDetails(categoryId: categoryId, childId: childId),
                        ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is BannerLoaded) {
            final uploads = state.banner.uploads;

            if (uploads.isEmpty) {
              return const Center(child: Text('इस श्रेणी में कोई बैनर नहीं मिला।'));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: uploads.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final banner = uploads[index];
                return GestureDetector(
                  onTap: () {
                    final template = EditorTemplate(
                      id: banner.bannerId,
                      backgroundUrl: banner.imageUrl ?? '',
                      title: banner.title,
                      isAsset: false,
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EditorPage(template: template),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: banner.imageUrl != null && banner.imageUrl!.trim().isNotEmpty
                          ? Image.network(
                              banner.imageUrl!,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                              },
                              errorBuilder: (context, error, stackTrace) => const Center(
                                child: Icon(Icons.broken_image, color: Colors.grey),
                              ),
                            )
                          : const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image_not_supported_outlined, color: Colors.grey, size: 40),
                                  SizedBox(height: 8),
                                  Text('No Image', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                            ),
                    ),
                  ),
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
