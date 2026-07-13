import 'package:flutter/material.dart';

/// Reusable placeholder used wherever a real network/asset image will
/// later be added (banner photo, template thumbnails, avatar, logo art).
/// Swap this out for Image.asset / Image.network once real files exist —
/// every screen already points at this ONE widget, so it's a single edit.
class PlaceholderBox extends StatelessWidget {
  final double? width;
  final double? height;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double borderRadius;
  final double iconSize;

  const PlaceholderBox({
    super.key,
    this.width,
    this.height,
    this.icon = Icons.image_outlined,
    this.backgroundColor = const Color(0xFFF0F0F0),
    this.iconColor = const Color(0xFFB0B0B0),
    this.borderRadius = 12,
    this.iconSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: iconColor, size: iconSize),
    );
  }
}
