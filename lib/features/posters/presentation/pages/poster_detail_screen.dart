import 'package:flutter/material.dart';
import 'package:flexwala/core/theme/app_colors.dart';
import 'package:flexwala/core/data/mock_data.dart';
import 'package:flexwala/core/widgets/common/custom_app_bar.dart';
import 'package:flexwala/core/widgets/common/page_indicator_dots.dart';
import 'package:flexwala/core/widgets/common/section_header.dart';
import 'package:flexwala/core/widgets/navigation/app_bottom_nav.dart';
import '../widgets/poster_card.dart';
import '../widgets/action_buttons_row.dart';
import '../widgets/related_templates_list.dart';

/// FlexWala poster preview screen - clean architecture version.
class PosterDetailScreen extends StatelessWidget {
  const PosterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        onBackTap: () => Navigator.maybePop(context),
        onLikeTap: () {},
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 0.72,
                child: PosterCard(imageUrl: MockData.mainPosterImage),
              ),
              const SizedBox(height: 16),
              ActionButtonsRow(
                onLikeTap: () {},
                onDownloadTap: () {},
              ),
              const SizedBox(height: 16),
              PageIndicatorDots(
                totalPages: MockData.totalPages,
                activeIndex: MockData.activePageIndex,
              ),
              const SizedBox(height: 24),
              const SectionHeader(title: 'Related Templates'),
              const SizedBox(height: 12),
              RelatedTemplatesList(templates: MockData.relatedTemplates),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 2,
        onItemTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/home');
          if (index == 1) Navigator.pushReplacementNamed(context, '/category');
        },
        onCenterTap: () => Navigator.pushReplacementNamed(context, '/home'),
      ),
    );
  }
}

