import 'package:flutter/material.dart';
import '../../../domain/entities/stroke.dart';

/// Eraser BlendMode.clear se implement hota hai (saveLayer ke andar),
/// isliye woh sach me stroke ko canvas se hata deta hai, sirf white
/// paint nahi karta — kisi bhi background color pe kaam karega.
class DrawingPainter extends CustomPainter {
  final List<Stroke> strokes;
  final Stroke? currentStroke;

  DrawingPainter({required this.strokes, this.currentStroke});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());
    for (final stroke in [...strokes, if (currentStroke != null) currentStroke!]) {
      _drawStroke(canvas, stroke);
    }
    canvas.restore();
  }

  void _drawStroke(Canvas canvas, Stroke stroke) {
    if (stroke.points.length < 2) return;
    final isEraser = stroke.tool == DrawTool.eraser;
    final paint = Paint()
      ..color = stroke.tool == DrawTool.marker ? stroke.color.withOpacity(0.55) : stroke.color
      ..strokeWidth = stroke.width
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..blendMode = isEraser ? BlendMode.clear : BlendMode.srcOver;

    final path = Path()..moveTo(stroke.points.first.dx, stroke.points.first.dy);
    for (final point in stroke.points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) => true;
}
