import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/shape_layer.dart';
import '../../domain/entities/stroke.dart';
import '../../domain/entities/template.dart';

abstract class EditorEvent extends Equatable {
  const EditorEvent();
  @override
  List<Object?> get props => [];
}

class LoadTemplates extends EditorEvent {
  const LoadTemplates();
}

class TemplateSelected extends EditorEvent {
  final EditorTemplate template;
  const TemplateSelected(this.template);
  @override
  List<Object?> get props => [template];
}

class LayerSelected extends EditorEvent {
  final String? id;
  const LayerSelected(this.id);
  @override
  List<Object?> get props => [id];
}

class LayerTransformed extends EditorEvent {
  final String id;
  final double dx;
  final double dy;
  final double scale;
  final double rotation;
  const LayerTransformed({
    required this.id,
    required this.dx,
    required this.dy,
    required this.scale,
    required this.rotation,
  });
  @override
  List<Object?> get props => [id, dx, dy, scale, rotation];
}

class LayerLockToggled extends EditorEvent {
  final String id;
  const LayerLockToggled(this.id);
  @override
  List<Object?> get props => [id];
}

class LayerDeleted extends EditorEvent {
  final String id;
  const LayerDeleted(this.id);
  @override
  List<Object?> get props => [id];
}

// ---------------- Text ----------------

class AddTextLayer extends EditorEvent {
  final String text;
  final double dx;
  final double dy;
  const AddTextLayer(this.text, {this.dx = 100, this.dy = 200});
  @override
  List<Object?> get props => [text, dx, dy];
}

class TextStyleChanged extends EditorEvent {
  final String id;
  final String? text;
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? color;
  final TextAlign? align;
  const TextStyleChanged({
    required this.id,
    this.text,
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.color,
    this.align,
  });
  @override
  List<Object?> get props => [id, text, fontFamily, fontSize, fontWeight, fontStyle, color, align];
}

// ---------------- Shapes ----------------

class AddShapeLayer extends EditorEvent {
  final ShapeKind kind;
  final double? dx;
  final double? dy;
  final String? imagePath;
  const AddShapeLayer(this.kind, {this.dx, this.dy, this.imagePath});
  @override
  List<Object?> get props => [kind, dx, dy, imagePath];
}

class ShapeStyleChanged extends EditorEvent {
  final String id;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderWidth;
  final String? imagePath;
  const ShapeStyleChanged({
    required this.id,
    this.fillColor,
    this.borderColor,
    this.borderWidth,
    this.imagePath,
  });
  @override
  List<Object?> get props => [id, fillColor, borderColor, borderWidth, imagePath];
}

// ---------------- Drawing ----------------

class DrawModeToggled extends EditorEvent {
  final bool isOn;
  const DrawModeToggled(this.isOn);
  @override
  List<Object?> get props => [isOn];
}

class DrawToolSelected extends EditorEvent {
  final DrawTool tool;
  const DrawToolSelected(this.tool);
  @override
  List<Object?> get props => [tool];
}

class DrawColorChanged extends EditorEvent {
  final Color color;
  const DrawColorChanged(this.color);
  @override
  List<Object?> get props => [color];
}

class DrawWidthChanged extends EditorEvent {
  final double width;
  const DrawWidthChanged(this.width);
  @override
  List<Object?> get props => [width];
}

class StrokeStarted extends EditorEvent {
  final Offset point;
  const StrokeStarted(this.point);
  @override
  List<Object?> get props => [point];
}

class StrokePointAdded extends EditorEvent {
  final Offset point;
  const StrokePointAdded(this.point);
  @override
  List<Object?> get props => [point];
}

class StrokeEnded extends EditorEvent {
  const StrokeEnded();
}

// ---------------- History ----------------

class UndoRequested extends EditorEvent {
  const UndoRequested();
}

class RedoRequested extends EditorEvent {
  const RedoRequested();
}

class SaveImageRequested extends EditorEvent {
  const SaveImageRequested();
}

class BackgroundImageChanged extends EditorEvent {
  final String path;
  final bool isAsset;
  const BackgroundImageChanged(this.path, {this.isAsset = false});
  @override
  List<Object?> get props => [path, isAsset];
}
