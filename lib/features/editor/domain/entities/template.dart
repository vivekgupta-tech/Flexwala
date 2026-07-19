class EditorTemplate {
  final String id;
  final String backgroundUrl;
  final String title;

  const EditorTemplate({
    required this.id,
    required this.backgroundUrl,
    required this.title,
  });

  factory EditorTemplate.fromJson(Map<String, dynamic> json) {
    return EditorTemplate(
      id: json['id'] as String,
      backgroundUrl: json['backgroundUrl'] as String,
      title: json['title'] as String? ?? '',
    );
  }
}
