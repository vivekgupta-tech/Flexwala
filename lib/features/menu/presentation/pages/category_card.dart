import 'package:flutter/material.dart';

class CategoryCardData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final Color bgColor;
  final String? imageUrl;

  const CategoryCardData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.bgColor,
    this.imageUrl,
  });
}

class CategoryCard extends StatelessWidget {
  final CategoryCardData data;
  final VoidCallback? onTap;

  const CategoryCard({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border(
            bottom: BorderSide(color: data.accentColor, width: 3),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: data.bgColor,
                shape: BoxShape.circle,
              ),
              child: data.imageUrl != null && data.imageUrl!.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        data.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(data.icon, color: data.accentColor, size: 22),
                      ),
                    )
                  : Icon(data.icon, color: data.accentColor, size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              data.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.subtitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF8B8B99),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

