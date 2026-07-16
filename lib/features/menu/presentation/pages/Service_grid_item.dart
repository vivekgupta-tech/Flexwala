import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ServiceItem {
  final String title;
  final String posterCount;
  final Widget icon;

  const ServiceItem({
    required this.title,
    required this.posterCount,
    required this.icon,
  });
}

class ServiceGridItem extends StatelessWidget {
  final ServiceItem item;
  final VoidCallback? onTap;

  const ServiceGridItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor),
          ),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20, width: 20, child: item.icon),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                    height: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Flexible(
                child: Text(
                  item.posterCount,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 7,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

