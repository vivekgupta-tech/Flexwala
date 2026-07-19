import '../entities/template.dart';

abstract class TemplateRepository {
  Future<List<EditorTemplate>> getTemplates();
}
