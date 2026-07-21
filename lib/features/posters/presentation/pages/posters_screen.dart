import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../editor/domain/entities/template.dart';
import '../../../template/editor_page.dart';
import '../bloc/poster_bloc.dart';
import '../bloc/poster_event.dart';
import '../bloc/poster_state.dart';

class PostersScreen extends StatelessWidget {
  final String childCategoryId;
  final String title;

  const PostersScreen({
    super.key,
    required this.childCategoryId,
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
      body: BlocBuilder<PosterBloc, PosterState>(
        builder: (context, state) {
          if (state is PosterLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple));
          } else if (state is PosterError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () => context.read<PosterBloc>().add(FetchPosters()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is PosterLoaded) {
            final filteredList = state.posters
                .where((item) => item.childId == childCategoryId)
                .toList();

            if (filteredList.isEmpty) {
              return const Center(child: Text('इस श्रेणी में कोई पोस्टर नहीं मिला।'));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final poster = filteredList[index];
                return GestureDetector(
                  onTap: () {
                    final template = EditorTemplate(
                      id: poster.id,
                      backgroundUrl: poster.imageUrl ?? '',
                      title: poster.title,
                      isAsset: false,
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EditorPage(template: template),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Image.network(
                        poster.imageUrl ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
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
