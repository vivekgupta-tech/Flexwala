import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/entities/shape_layer.dart';
import '../../bloc/editor_bloc.dart';
import '../../bloc/editor_event.dart';
import '../panels/layer_quick_panel.dart';
import 'toolbar_chrome.dart';

/// Shape select hone par: fill color, andar image upload (signature/
/// logo bhi isi se), border on/off, delete.
class ShapeSelectionToolbar extends StatelessWidget {
  final ShapeLayer layer;
  const ShapeSelectionToolbar({super.key, required this.layer});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditorBloc>();
    return ToolbarChrome(
      children: [
        GestureDetector(
          onTap: () async {
            final result = await showLayerQuickPanel(context: context, type: LayerPanelType.color);
            if (result != null) bloc.add(ShapeStyleChanged(id: layer.id, fillColor: result as Color));
          },
          child: CircleAvatar(radius: 12, backgroundColor: layer.fillColor),
        ),
        ToolbarIcon(
          icon: Icons.image_outlined,
          onTap: () async {
            final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
            if (picked != null) bloc.add(ShapeStyleChanged(id: layer.id, imagePath: picked.path));
          },
        ),
        ToolbarIcon(
          icon: Icons.border_style_rounded,
          isActive: layer.borderWidth > 0,
          onTap: () => bloc.add(ShapeStyleChanged(
            id: layer.id,
            borderWidth: layer.borderWidth > 0 ? 0 : 3,
            borderColor: Colors.white,
          )),
        ),
        ToolbarIcon(icon: Icons.delete_outline_rounded, onTap: () => bloc.add(LayerDeleted(layer.id))),
      ],
    );
  }
}
