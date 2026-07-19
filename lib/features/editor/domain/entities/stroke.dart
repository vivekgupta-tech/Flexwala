import 'package:flutter/material.dart';

enum DrawTool { pen, marker, pencil, eraser }

/// Pen/marker/pencil sirf width+opacity ke combination se differentiate
/// hote hain, eraser BlendMode.clear use karta hai (DrawingPainter me).
class Stroke {
  final List<Offset> points;
  final Color color;
  final double width;
  final DrawTool tool;

  const Stroke({
    required this.points,
    required this.color,
    required this.width,
    required this.tool,
  });

  Stroke copyWith({List<Offset>? points}) {
    return Stroke(points: points ?? this.points, color: color, width: width, tool: tool);
  }
}
