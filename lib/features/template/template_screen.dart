import 'package:flutter/material.dart';
import '../../../editor/data/repositories/static_template_repository.dart';
import '../../../editor/domain/entities/template.dart';
import '../../../editor/presentation/pages/editor_page.dart';

/// General Store / Medical Store / Fast Food — sab isi ek screen ko
/// reuse karenge, bas [subCategoryName] alag pass hoga (title ke liye).
/// Abhi StaticTemplateRepository se 2 asset images grid me aate hain,
/// tap karte hi EditorPage khul jaata hai us image ke saath.
///
/// Kahi se bhi is tarah push karo:
///   Navigator.push(context, MaterialPageRoute(
///     builder: (_) => const TemplateScreen(subCategoryName: 'General Store'),
///   ));
class TemplateScreen extends StatelessWidget {
  final String subCategoryName;
  const TemplateScreen({super.key, required this.subCategoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subCategoryName)),
      body: FutureBuilder<List<EditorTemplate>>(
        // TODO: API ready hote hi StaticTemplateRepository() ko apne
        // Dio-wale TemplateRepositoryImpl(subCategoryName) se replace karna.
        future: StaticTemplateRepository().getTemplates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final templates = snapshot.data ?? const [];
          if (templates.isEmpty) {
            return const Center(child: Text('Is category me abhi koi template nahi hai'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final template = templates[index];
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => EditorPage(template: template)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                    child: template.isAsset
                        ? Image.asset(template.backgroundUrl, fit: BoxFit.cover)
                        : Image.network(template.backgroundUrl, fit: BoxFit.cover),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}