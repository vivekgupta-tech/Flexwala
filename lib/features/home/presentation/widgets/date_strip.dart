import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/date_item.dart';

/// "Today's Date" section header + horizontal scrollable date chips.
class DateStrip extends StatelessWidget {
  final List<DateItem> dates;
  final VoidCallback? onSeeCalendarTap;

  const DateStrip({super.key, required this.dates, this.onSeeCalendarTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: AppColors.primaryOrange,
                ),
                const SizedBox(width: 6),
                Text("Today's Date", style: AppTextStyles.sectionTitle),
              ],
            ),
            InkWell(
              onTap: onSeeCalendarTap,
              child: Row(
                children: [
                  Text('See Calendar', style: AppTextStyles.sectionLink),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.arrow_forward,
                    size: 13,
                    color: AppColors.primaryOrange,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 78,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final d = dates[index];
              return Container(
                width: 58,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: d.isToday ? AppColors.primaryOrange : AppColors.cardBorder,
                    width: d.isToday ? 1.4 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      d.weekday,
                      style: AppTextStyles.dateDay.copyWith(
                        color: d.isToday ? AppColors.primaryOrange : AppColors.textGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      d.day,
                      style: AppTextStyles.dateNumber.copyWith(
                        color: d.isToday
                            ? AppColors.primaryOrange
                            : (d.numberColor ?? AppColors.textDark),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(d.month, style: AppTextStyles.dateMonth),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
