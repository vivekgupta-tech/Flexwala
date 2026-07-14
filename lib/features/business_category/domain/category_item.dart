import 'package:flutter/material.dart';

/// A single category tile in the Business category grid (Image 2).
class CategoryItem {
  final String id;
  final String name;
  final int postCount;
  final IconData emojiIcon;
  final Color iconBackground;
  final bool isFavorite;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.postCount,
    required this.emojiIcon,
    required this.iconBackground,
    this.isFavorite = false,
  });
}
