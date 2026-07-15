import 'package:flutter/material.dart';
import 'package:flexwala/core/models/feature_item_model.dart';
import 'package:flexwala/core/widgets/common/hexagon_icon.dart';

import '../../../../core/theme/app_text_styles.dart';

/// Reusable single feature row: hexagon icon + title + subtitle.
/// Data model se driven hai, koi text hardcode nahi.
class FeatureListItem extends StatelessWidget {
  final FeatureItemModel data;

  const FeatureListItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          HexagonIcon(icon: data.icon, color: data.hexColor),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(data.title, style: AppTextStyles.featureTitle),
              Text(data.subtitle, style: AppTextStyles.featureSubtitle),
            ],
          ),
        ],
      ),
    );
  }
}

