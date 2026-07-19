import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/shape_layer.dart';
import '../../bloc/editor_bloc.dart';
import '../../bloc/editor_event.dart';
import 'toolbar_chrome.dart';

/// "Shapes" category tap karne pe ye khulta hai — kaunsa shape kind
/// chahiye, tap karte hi wo shape canvas ke center me add ho jaata hai
/// aur turant selected ho jaata hai (fir ShapeSelectionToolbar aata hai).
class ShapeToolbar extends StatelessWidget {
  final VoidCallback? onPicked;
  const ShapeToolbar({super.key, this.onPicked});

  static const _kinds = [
    (ShapeKind.rectangle, Icons.crop_square_rounded),
    (ShapeKind.circle, Icons.circle_outlined),
    (ShapeKind.triangle, Icons.change_history_rounded),
    (ShapeKind.star, Icons.star_border_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return ToolbarChrome(
      children: [
        for (final entry in _kinds)
          ToolbarIcon(
            icon: entry.$2,
            onTap: () {
              context.read<EditorBloc>().add(AddShapeLayer(entry.$1));
              onPicked?.call();
            },
          ),
      ],
    );
  }
}
