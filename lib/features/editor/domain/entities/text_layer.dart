import 'package:flutter/material.dart';
import 'layer.dart';

class TextLayer extends Layer {
  final String text;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final double letterSpacing;
  final TextAlign align;

  const TextLayer({
    required super.id,
    required this.text,
    this.fontFamily = 'Roboto',
    this.fontSize = 22,
    this.fontWeight = FontWeight.w500,
    this.color = Colors.black,
    this.letterSpacing = 0,
    this.align = TextAlign.center,
    super.dx,
    super.dy,
    super.scale,
    super.rotation,
    super.opacity,
    super.zIndex,
    super.isLocked,
  }) : super(type: LayerType.text);

  TextLayer copyWith({
    String? text,
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    TextAlign? align,
    double? dx,
    double? dy,
    double? scale,
    double? rotation,
    double? opacity,
    bool? isLocked,
  }) {
    return TextLayer(
      id: id,
      text: text ?? this.text,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      color: color ?? this.color,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      align: align ?? this.align,
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
  TextLayer withTransform({double? dx, double? dy, double? scale, double? rotation}) =>
      copyWith(dx: dx, dy: dy, scale: scale, rotation: rotation);

  @override
  TextLayer withLock(bool locked) => copyWith(isLocked: locked);

  @override
  List<Object?> get props => [...super.props, text, fontFamily, fontSize, color];
}
