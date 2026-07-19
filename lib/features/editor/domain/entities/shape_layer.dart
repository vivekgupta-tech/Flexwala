import 'package:flutter/material.dart';
import 'layer.dart';

enum ShapeKind { rectangle, circle, triangle, star, line }

/// Signature aur shop-logo bhi isi ShapeLayer se aate hain — bas
/// kind = rectangle/circle rakh ke imagePath set kar do.
class ShapeLayer extends Layer {
  final ShapeKind kind;
  final double width;
  final double height;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final String? imagePath;

  const ShapeLayer({
    required super.id,
    this.kind = ShapeKind.rectangle,
    this.width = 140,
    this.height = 140,
    this.fillColor = Colors.blueAccent,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.imagePath,
    super.dx,
    super.dy,
    super.scale,
    super.rotation,
    super.opacity,
    super.zIndex,
    super.isLocked,
  }) : super(type: LayerType.shape);

  ShapeLayer copyWith({
    ShapeKind? kind,
    double? width,
    double? height,
    Color? fillColor,
    Color? borderColor,
    double? borderWidth,
    String? imagePath,
    double? dx,
    double? dy,
    double? scale,
    double? rotation,
    double? opacity,
    bool? isLocked,
  }) {
    return ShapeLayer(
      id: id,
      kind: kind ?? this.kind,
      width: width ?? this.width,
      height: height ?? this.height,
      fillColor: fillColor ?? this.fillColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      imagePath: imagePath ?? this.imagePath,
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
      scale: scale ?? this.scale,
      rotation: rotation ?? this.rotation,
      opacity: opacity ?? this.opacity,
      zIndex: zIndex,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  @override
  ShapeLayer withTransform({double? dx, double? dy, double? scale, double? rotation}) =>
      copyWith(dx: dx, dy: dy, scale: scale, rotation: rotation);

  @override
  ShapeLayer withLock(bool locked) => copyWith(isLocked: locked);

  @override
  List<Object?> get props =>
      [...super.props, kind, width, height, fillColor, borderColor, borderWidth, imagePath];
}
