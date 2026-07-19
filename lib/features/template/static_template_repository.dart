

import '../editor/domain/entities/template.dart';
import '../editor/domain/repositories/template_repository.dart';

class StaticTemplateRepository implements TemplateRepository {
  @override
  Future<List<EditorTemplate>> getTemplates() async {
    return const [
      EditorTemplate(
        id: 'static_1',
        title: 'Template 1',
        backgroundUrl: 'assets/images/template1.png',
        isAsset: true,
      ),
      EditorTemplate(
        id: 'static_2',
        title: 'Template 2',
        backgroundUrl: 'assets/images/template2.png',
        isAsset: true,
      ),
    ];
  }
}