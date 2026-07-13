import 'package:flutter/material.dart';
import 'package:flexify/core/theme/app_colors.dart';

import '../../../../core/data/mock_data.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/common/flexwala_logo.dart';
import 'feature_list_item.dart';
import 'join_now_button.dart';

/// Reusable hero poster card - clean architecture version.
class PosterCard extends StatelessWidget {
  final String imageUrl;

  const PosterCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: AppColors.cardWhite,
        child: Stack(
          children: [
            Positioned.fill(
              child: Row(
                children: [
                  const Expanded(flex: 42, child: SizedBox()),
                  Expanded(flex: 58, child: _BrushBackground(imageUrl: imageUrl)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
              child: FractionallySizedBox(
                widthFactor: 0.58,
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const FlexwalaLogo(fontSize: 13, iconSize: 15),
                      const SizedBox(height: 8),
                      const Text('SHAPE',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            height: 0.95,
                            color: AppColors.darkNavy,
                          )),
                      const Text('YOUR',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            height: 0.95,
                            color: AppColors.primaryOrange,
                          )),
                      const Text('BODY',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            height: 0.95,
                            color: AppColors.darkNavy,
                          )),
                      const SizedBox(height: 8),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'BE STRONG\n',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryBlue,
                              ),
                            ),
                            TextSpan(
                              text: 'THAN YOUR EXCUSES',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: AppColors.darkNavy,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(width: 30, height: 3, color: AppColors.primaryOrange),
                      const SizedBox(height: 8),
                      ...MockData.features.map((f) => FeatureListItem(data: f)),
                      const SizedBox(height: 10),
                      const JoinNowButton(),
                      const SizedBox(height: 8),
                      const Text(MockData.websiteUrl, style: AppTextStyles.website),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrushBackground extends StatelessWidget {
  final String imageUrl;
  const _BrushBackground({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: AppColors.cardWhite),
        Positioned(
          left: -50,
          top: -20,
          bottom: -20,
          width: 100,
          child: Transform.rotate(
            angle: -0.35,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryOrange.withOpacity(0.9),
                    AppColors.primaryOrange.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: -70,
          top: -20,
          bottom: -20,
          width: 180,
          child: Transform.rotate(
            angle: -0.35,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryBlue.withOpacity(0.95),
                    AppColors.primaryBlue.withOpacity(0.55),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            errorBuilder: (_, __, ___) => Container(color: AppColors.darkNavy),
          ),
        ),
      ],
    );
  }
}
