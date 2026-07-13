import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../models/feature_item_model.dart';
import '../models/template_model.dart';
import '../models/template_text_line.dart';


/// ⚠️ Ye file sirf STATIC / MOCK data ke liye hai.
/// Screens/widgets me kahi bhi text ya image hardcode nahi kiya gaya -
/// sab yahi se supply ho raha hai. Real app me isko API/repository
/// se replace kar sakte ho, UI widgets me kuch change nahi karna padega.
class MockData {
  MockData._();

  // Placeholder network image (Unsplash) - jaisa aapne bola
  static const String mainPosterImage =
      'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800&q=80';

  static const String websiteUrl = 'www.flexwala.com';

  static final List<FeatureItemModel> features = [
    FeatureItemModel(
      icon: Icons.fitness_center,
      title: 'BUILD MUSCLE',
      subtitle: 'GET STRONG',
      hexColor: AppColors.hexOrange,
    ),
    FeatureItemModel(
      icon: Icons.favorite,
      title: 'STAY FIT',
      subtitle: 'STAY HEALTHY',
      hexColor: AppColors.hexBlue,
    ),
    FeatureItemModel(
      icon: Icons.accessibility_new,
      title: 'ACHIEVE GOALS',
      subtitle: 'TRANSFORM LIFE',
      hexColor: AppColors.hexOrange,
    ),
  ];

  static const int totalPages = 7;
  static const int activePageIndex = 3;

  static final List<TemplateModel> relatedTemplates = [
    TemplateModel(
      imageUrl:
          'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=400&q=80',
      titleLines: const [
        TemplateTextLine(text: 'NO PAIN', color: Colors.white),
        TemplateTextLine(text: 'NO GAIN', color: AppColors.primaryOrange),
      ],
      buttonColor: AppColors.primaryOrange,
    ),
    TemplateModel(
      imageUrl:
          'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400&q=80',
      titleLines: const [
        TemplateTextLine(text: 'TRAIN', color: Colors.white),
        TemplateTextLine(text: 'HARD', color: AppColors.primaryOrange),
        TemplateTextLine(text: 'STAY', color: Colors.white),
        TemplateTextLine(text: 'STRONG', color: AppColors.primaryOrange),
      ],
      buttonColor: AppColors.primaryOrange,
    ),
    TemplateModel(
      imageUrl:
          'https://images.unsplash.com/photo-1594381898411-846e7d193883?w=400&q=80',
      titleLines: const [
        TemplateTextLine(text: 'PUSH', color: Colors.white),
        TemplateTextLine(text: 'YOUR', color: AppColors.primaryBlue),
        TemplateTextLine(text: 'LIMITS', color: Colors.white),
      ],
      buttonColor: AppColors.primaryBlue,
    ),
    TemplateModel(
      imageUrl:
          'https://images.unsplash.com/photo-1517963879433-6ad2b056d712?w=400&q=80',
      titleLines: const [
        TemplateTextLine(text: 'FOCUS', color: Colors.white),
        TemplateTextLine(text: 'DISCIPLINE', color: Color(0xFFE53935)),
        TemplateTextLine(text: 'SUCCESS', color: Colors.white),
      ],
      buttonColor: const Color(0xFFE53935),
    ),
    TemplateModel(
      imageUrl:
          'https://images.unsplash.com/photo-1571731956672-f2b94d7dd0cb?w=400&q=80',
      titleLines: const [
        TemplateTextLine(text: 'BETTER', color: Colors.white),
        TemplateTextLine(text: 'SORE', color: Color(0xFF43A047)),
        TemplateTextLine(text: 'THAN SORRY', color: Color(0xFF43A047)),
      ],
      buttonColor: const Color(0xFF43A047),
    ),
  ];
}
