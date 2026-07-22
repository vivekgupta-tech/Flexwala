import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/stroke.dart';
import '../../bloc/editor_bloc.dart';
import '../../bloc/editor_event.dart';
import '../panels/layer_quick_panel.dart';
import 'toolbar_chrome.dart';

/// Draw mode on hone par dikhta hai: pen/marker/pencil/eraser, color,
/// thickness slider, aur ek "done" jo draw mode band karta hai.
class DrawToolbar extends StatelessWidget {
  const DrawToolbar({super.key});

  static const _tools = [
    (DrawTool.pen, Icons.edit_rounded),
    (DrawTool.marker, Icons.brush_rounded),
    (DrawTool.pencil, Icons.create_rounded),
    (DrawTool.eraser, Icons.auto_fix_normal_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditorBloc>();
    final state = context.watch<EditorBloc>().state;

    return ToolbarChrome(
      children: [
        ToolbarIcon(
          icon: Icons.undo_rounded,
          onTap: () => bloc.add(const UndoRequested()),
        ),
        ToolbarIcon(
          icon: Icons.redo_rounded,
          onTap: () => bloc.add(const RedoRequested()),
        ),
        const SizedBox(width: 8),
        for (final entry in _tools)
          ToolbarIcon(
            icon: entry.$2,
            isActive: state.activeDrawTool == entry.$1,
            onTap: () => bloc.add(DrawToolSelected(entry.$1)),
          ),
        GestureDetector(
          onTap: () async {
            final result = await showLayerQuickPanel(context: context, type: LayerPanelType.color);
            if (result != null) bloc.add(DrawColorChanged(result as Color));
          },
          child: CircleAvatar(radius: 12, backgroundColor: state.activeDrawColor),
        ),
        SizedBox(
          width: 80,
          child: Slider(
            value: state.activeDrawWidth,
            min: 1,
            max: 30,
            activeColor: Colors.blueAccent,
            onChanged: (v) => bloc.add(DrawWidthChanged(v)),
          ),
        ),
        ToolbarIcon(icon: Icons.check_circle_outline, onTap: () => bloc.add(const DrawModeToggled(false))),
      ],
    );
  }
}
