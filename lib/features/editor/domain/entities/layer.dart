import 'package:equatable/equatable.dart';

enum LayerType { text, shape, image, drawing }

/// Base class jise TextLayer, ShapeLayer, ImageLayer extend karte hain.
/// withTransform/withLock generic hain isliye EditorBloc aur
/// TransformableLayer kisi bhi layer type ko bina type-check kiye
/// drag/scale/rotate/lock kar sakte hain.
abstract class Layer extends Equatable {
  final String id;
  final LayerType type;
  final double dx;
  final double dy;
  final double scale;
  final double rotation;
  final double opacity;
  final int zIndex;
  final bool isLocked;

  const Layer({
    required this.id,
    required this.type,
    this.dx = 0,
    this.dy = 0,
    this.scale = 1,
    this.rotation = 0,
    this.opacity = 1,
    this.zIndex = 0,
    this.isLocked = false,
  });

  Layer withTransform({double? dx, double? dy, double? scale, double? rotation});

  Layer withLock(bool locked);

  @override
  List<Object?> get props =>
      [id, type, dx, dy, scale, rotation, opacity, zIndex, isLocked];
}
