import 'package:flutter/material.dart';

/// Ek feature row (icon + title + subtitle) ka data model.
class FeatureItemModel {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color hexColor;

  const FeatureItemModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.hexColor,
  });
}
