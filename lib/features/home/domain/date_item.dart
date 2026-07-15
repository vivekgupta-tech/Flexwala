import 'package:flutter/material.dart';

/// A single date chip in the horizontal "Today's Date" strip.
class DateItem {
  final String weekday;
  final String day;
  final String month;
  final bool isToday;
  final Color? numberColor;

  const DateItem({
    required this.weekday,
    required this.day,
    required this.month,
    this.isToday = false,
    this.numberColor,
  });
}

