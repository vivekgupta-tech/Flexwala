import 'package:flutter/material.dart';
import '../domain/template_item.dart';
import '../domain/date_item.dart';

/// Mock data powering the Home page — matches Image 1 exactly.
class HomeMockData {
  HomeMockData._();

  static const userName = 'Uday';
  static const notificationCount = 3;

  static const List<DateItem> dates = [
    DateItem(weekday: 'Sat', day: '17', month: 'May', isToday: true),
    DateItem(weekday: 'Sun', day: '18', month: 'May'),
    DateItem(weekday: 'Mon', day: '19', month: 'May'),
    DateItem(
      weekday: 'Tue',
      day: '20',
      month: 'May',
      numberColor: Color(0xFF7C3AED),
    ),
    DateItem(weekday: 'Wed', day: '21', month: 'May'),
    DateItem(
      weekday: 'Thu',
      day: '22',
      month: 'May',
      numberColor: Color(0xFF7C3AED),
    ),
    DateItem(weekday: 'Fri', day: '23', month: 'May'),
  ];

  static const List<TemplateItem> templates = [
    TemplateItem(
      id: 't1',
      title: 'BE STRONG\nBE FIT',
      subtitle: 'Shape Your Perfect Body',
      phone: '+91 12345 67890',
      backgroundColor: Color(0xFF1A1A1A),
      icon: Icons.fitness_center,
    ),
    TemplateItem(
      id: 't2',
      title: 'Your Health\nOur Priority',
      subtitle: 'Quality Care for a Better Life',
      phone: '+91 12345 67890',
      backgroundColor: Color(0xFFCFE8F7),
      icon: Icons.medical_services_outlined,
      isFavorite: true,
    ),
    TemplateItem(
      id: 't3',
      title: 'HAPPY\nDiwali',
      subtitle: 'FESTIVAL OF LIGHTS AND HAPPINESS',
      phone: '',
      backgroundColor: Color(0xFF2B0B12),
      icon: Icons.local_fire_department,
    ),
    TemplateItem(
      id: 't4',
      title: 'FIND YOUR\nDREAM HOME',
      subtitle: 'Modern Living Better Future',
      phone: '+91 12345 67890',
      backgroundColor: Color(0xFF16324A),
      icon: Icons.home_work_outlined,
    ),
  ];
}
