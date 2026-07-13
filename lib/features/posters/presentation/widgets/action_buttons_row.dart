import 'package:flutter/material.dart';
import 'package:flexify/core/theme/app_colors.dart';

/// Reusable "Like" (outlined) + "Download" (gradient) button row.
class ActionButtonsRow extends StatelessWidget {
  final VoidCallback? onLikeTap;
  final VoidCallback? onDownloadTap;

  const ActionButtonsRow({super.key, this.onLikeTap, this.onDownloadTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onLikeTap,
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.cardWhite,
              side: const BorderSide(color: AppColors.borderLight),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            icon: const Icon(Icons.favorite_border, color: AppColors.darkNavy),
            label: const Text(
              'Like',
              style: TextStyle(
                color: AppColors.darkNavy,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                colors: [AppColors.primaryOrange, AppColors.primaryBlue],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: onDownloadTap,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.file_download_outlined, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Download',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
