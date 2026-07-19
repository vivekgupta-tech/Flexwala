import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/text_layer.dart';
import '../../bloc/editor_bloc.dart';
import '../../bloc/editor_event.dart';
import '../panels/layer_quick_panel.dart';
import '../sheets/text_input_sheet.dart';
import 'toolbar_chrome.dart';

/// Jab bhi ek TextLayer canvas par selected hota hai, ye chhota
/// floating toolbar canvas ke upar aa jaata hai — edit / size / bold /
/// color / delete. Baaki poori screen tab bhi free rehti hai.
class TextSelectionToolbar extends StatelessWidget {
  final TextLayer layer;
  const TextSelectionToolbar({super.key, required this.layer});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditorBloc>();
    return ToolbarChrome(
      children: [
        ToolbarIcon(
          icon: Icons.edit_note_rounded,
          onTap: () async {
            final text = await showTextInputSheet(context, initialText: layer.text);
            if (text != null && text.isNotEmpty) {
              bloc.add(TextStyleChanged(id: layer.id, text: text));
            }
          },
        ),
        ToolbarIcon(
          icon: Icons.remove,
          onTap: () => bloc.add(
              TextStyleChanged(id: layer.id, fontSize: (layer.fontSize - 2).clamp(8, 120))),
        ),
        Text('${layer.fontSize.toInt()}', style: const TextStyle(color: Colors.white, fontSize: 12)),
        ToolbarIcon(
          icon: Icons.add,
          onTap: () => bloc.add(
              TextStyleChanged(id: layer.id, fontSize: (layer.fontSize + 2).clamp(8, 120))),
        ),
        ToolbarIcon(
          icon: Icons.format_bold_rounded,
          isActive: layer.fontWeight == FontWeight.bold,
          onTap: () => bloc.add(TextStyleChanged(
            id: layer.id,
            fontWeight: layer.fontWeight == FontWeight.bold ? FontWeight.w500 : FontWeight.bold,
          )),
        ),
        GestureDetector(
          onTap: () async {
            final result = await showLayerQuickPanel(context: context, type: LayerPanelType.color);
            if (result != null) bloc.add(TextStyleChanged(id: layer.id, color: result as Color));
          },
          child: CircleAvatar(radius: 12, backgroundColor: layer.color),
        ),
        ToolbarIcon(icon: Icons.delete_outline_rounded, onTap: () => bloc.add(LayerDeleted(layer.id))),
      ],
    );
  }
}
