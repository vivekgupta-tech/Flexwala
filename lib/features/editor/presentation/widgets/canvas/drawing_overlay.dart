import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/editor_bloc.dart';
import '../../bloc/editor_event.dart';
import '../../bloc/editor_state.dart';
import 'drawing_painter.dart';

/// Sirf isDrawMode true hone par touches capture karta hai, warna
/// IgnorePointer se neeche wale text/shape layers ke gestures ko
/// bina rukawat ke jaane deta hai.
class DrawingOverlay extends StatelessWidget {
  const DrawingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) {
        final painter = CustomPaint(
          painter: DrawingPainter(strokes: state.strokes, currentStroke: state.currentStroke),
          size: Size.infinite,
        );

        if (!state.isDrawMode) return IgnorePointer(child: painter);

        return GestureDetector(
          onPanStart: (d) => context.read<EditorBloc>().add(StrokeStarted(d.localPosition)),
          onPanUpdate: (d) => context.read<EditorBloc>().add(StrokePointAdded(d.localPosition)),
          onPanEnd: (_) => context.read<EditorBloc>().add(const StrokeEnded()),
          child: painter,
        );
      },
    );
  }
}
