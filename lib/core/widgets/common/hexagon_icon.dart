import 'package:flutter/material.dart';

class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    return Path()
      ..moveTo(w * 0.5, 0)
      ..lineTo(w, h * 0.25)
      ..lineTo(w, h * 0.75)
      ..lineTo(w * 0.5, h)
      ..lineTo(0, h * 0.75)
      ..lineTo(0, h * 0.25)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Reusable hexagon icon badge used in the feature list
/// (BUILD MUSCLE / STAY FIT / ACHIEVE GOALS icons).
class HexagonIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const HexagonIcon({
    super.key,
    required this.icon,
    required this.color,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _HexagonClipper(),
      child: Container(
        width: size,
        height: size,
        color: color,
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: size * 0.5),
      ),
    );
  }
}

