import 'package:flutter/material.dart';
import 'template_text_line.dart';

/// "Related Templates" section ke ek card ka data model.
class TemplateModel {
  final String imageUrl;
  final List<TemplateTextLine> titleLines;
  final Color buttonColor;

  const TemplateModel({
    required this.imageUrl,
    required this.titleLines,
    required this.buttonColor,
  });
}
