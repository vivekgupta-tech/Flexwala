import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/editor_bloc.dart';
import '../../bloc/editor_event.dart';
import '../../bloc/editor_state.dart';
import '../sheets/text_input_sheet.dart';
import 'drawing_overlay.dart';
import 'transformable_layer.dart';

/// DrawingOverlay isi RepaintBoundary ke andar hai isliye HD export me
/// freehand strokes bhi shamil hote hain, sirf layers nahi.
class EditorCanvas extends StatelessWidget {
  const EditorCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) {
        return RepaintBoundary(
          key: state.canvasKey,
          child: Container(
            color: Colors.grey.shade900,
            child: Stack(
              fit: StackFit.expand,
              children: [
                GestureDetector(
                  onTapDown: (details) async {
                    final bloc = context.read<EditorBloc>();
                    // Deselect any layer
                    bloc.add(const LayerSelected(null));

                    if (state.isDrawMode) return;

                    // Open transparent text input sheet at the tapped position
                    final text = await showTextInputSheet(
                      context, 
                      tapPosition: details.globalPosition,
                    );
                    if (text != null && text.isNotEmpty) {
                      bloc.add(AddTextLayer(
                        text, 
                        dx: details.localPosition.dx, 
                        dy: details.localPosition.dy,
                      ));
                    }
                  },
                  child: state.backgroundUrl != null
                      ? (state.isAssetBackground
                          ? Image.asset(state.backgroundUrl!, fit: BoxFit.cover)
                          : Image.network(state.backgroundUrl!, fit: BoxFit.cover))
                      : const Center(
                          child: Text(
                            'Template select karo shuru karne ke liye',
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                ),
                for (final layer in state.layers)
                  TransformableLayer(
                    key: ValueKey(layer.id),
                    layer: layer,
                    isSelected: layer.id == state.selectedLayerId,
                  ),
                const DrawingOverlay(),
              ],
            ),
          ),
        );
      },
    );
  }
}
