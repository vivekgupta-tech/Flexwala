import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/layer.dart';
import '../../../domain/entities/shape_layer.dart';
import '../../../domain/entities/text_layer.dart';
import '../../bloc/editor_bloc.dart';
import '../../bloc/editor_event.dart';
import 'shape_clippers.dart';

/// Flutter ka onScaleStart/Update ek hi callback me pan + pinch-zoom +
/// rotation teeno deta hai, isliye har layer type ke liye alag gesture
/// logic nahi likhni padti — sirf content render karna alag hota hai.
class TransformableLayer extends StatefulWidget {
  final Layer layer;
  final bool isSelected;

  const TransformableLayer({super.key, required this.layer, required this.isSelected});

  @override
  State<TransformableLayer> createState() => _TransformableLayerState();
}

class _TransformableLayerState extends State<TransformableLayer> {
  late double _startScale;
  late double _startRotation;

  @override
  Widget build(BuildContext context) {
    final layer = widget.layer;

    return Positioned(
      left: layer.dx,
      top: layer.dy,
      child: IgnorePointer(
        ignoring: layer.isLocked,
        child: GestureDetector(
          onTap: () => context.read<EditorBloc>().add(LayerSelected(layer.id)),
          onScaleStart: (_) {
            _startScale = layer.scale;
            _startRotation = layer.rotation;
          },
          onScaleUpdate: (details) {
            context.read<EditorBloc>().add(LayerTransformed(
                  id: layer.id,
                  dx: layer.dx + details.focalPointDelta.dx,
                  dy: layer.dy + details.focalPointDelta.dy,
                  scale: (_startScale * details.scale).clamp(0.2, 6.0),
                  rotation: _startRotation + details.rotation,
                ));
          },
          child: Transform.rotate(
            angle: layer.rotation,
            child: Transform.scale(
              scale: layer.scale,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: widget.isSelected
                    ? BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.5,
                        ),
                      )
                    : null,
                child: _buildContent(layer),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TODO: ImageLayer bante hi yaha uska render branch add karna.
  Widget _buildContent(Layer layer) {
    if (layer is TextLayer) {
      return Opacity(
        opacity: layer.opacity,
        child: Text(
          layer.text,
          textAlign: layer.align,
          style: TextStyle(
            fontFamily: layer.fontFamily,
            fontSize: layer.fontSize,
            fontWeight: layer.fontWeight,
            color: layer.color,
            letterSpacing: layer.letterSpacing,
          ),
        ),
      );
    }
    if (layer is ShapeLayer) {
      return Opacity(opacity: layer.opacity, child: _buildShape(layer));
    }
    return const SizedBox.shrink();
  }

  Widget _buildShape(ShapeLayer layer) {
    final child = layer.imagePath != null
        ? Image.file(File(layer.imagePath!), fit: BoxFit.cover)
        : Container(color: layer.fillColor);

    Widget shape;
    switch (layer.kind) {
      case ShapeKind.circle:
        shape = ClipOval(child: child);
        break;
      case ShapeKind.triangle:
        shape = ClipPath(clipper: const TriangleClipper(), child: child);
        break;
      case ShapeKind.star:
        shape = ClipPath(clipper: const StarClipper(), child: child);
        break;
      case ShapeKind.rectangle:
      case ShapeKind.line:
        shape = child;
        break;
    }

    return Container(
      width: layer.width,
      height: layer.height,
      decoration: layer.borderWidth > 0
          ? BoxDecoration(border: Border.all(color: layer.borderColor, width: layer.borderWidth))
          : null,
      child: shape,
    );
  }
}
