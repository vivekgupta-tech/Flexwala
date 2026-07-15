import 'package:flutter/material.dart';
import 'package:flexwala/core/models/template_model.dart';
import 'related_template_card.dart';

/// Reusable horizontal scrollable list of related template cards.
class RelatedTemplatesList extends StatelessWidget {
  final List<TemplateModel> templates;

  const RelatedTemplatesList({super.key, required this.templates});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: templates.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return RelatedTemplateCard(data: templates[index]);
        },
      ),
    );
  }
}

