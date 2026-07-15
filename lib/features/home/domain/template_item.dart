import 'package:flutter/material.dart';

/// A single "Today's Templates" card on the Home page.
class TemplateItem {
  final String id;
  final String title;
  final String subtitle;
  final String phone;
  final Color backgroundColor;
  final IconData icon;
  final bool isFavorite;

  const TemplateItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.phone,
    required this.backgroundColor,
    required this.icon,
    this.isFavorite = false,
  });
}

