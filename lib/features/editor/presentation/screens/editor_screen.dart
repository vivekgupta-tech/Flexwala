import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/shape_layer.dart';
import '../../domain/entities/text_layer.dart';
import '../bloc/editor_bloc.dart';
import '../bloc/editor_event.dart';
import '../bloc/editor_state.dart';
import '../widgets/canvas/editor_canvas.dart';
import '../widgets/panels/layer_quick_panel.dart';
import '../widgets/sheets/template_picker_sheet.dart';
import '../widgets/sheets/text_input_sheet.dart';
import '../widgets/sheets/tools_bottom_sheet.dart';
import '../widgets/toolbars/draw_toolbar.dart';
import '../widgets/toolbars/shape_selection_toolbar.dart';
import '../widgets/toolbars/shape_toolbar.dart';
import '../widgets/toolbars/TextLayerToolbar.dart';

/// Screen bilkul free rehti hai. Top pe sirf back + 1 menu icon.
/// Bottom-right corner me 3 chhote floating icons (Template, draw
/// color, draw thickness). Text/Shape select hone par ya Draw mode on
/// hone par canvas ke bilkul upar ek chhota contextual toolbar aata
/// hai — baaki poora screen hamesha free rehta hai.
class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  bool _showShapePicker = false;

  Future<void> _openToolsMenu() async {
    final category = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ToolsBottomSheet(),
    );
    if (category == null || !mounted) return;
    final bloc = context.read<EditorBloc>();

    switch (category) {
      case 'Text':
        final text = await showTextInputSheet(context);
        if (text != null && text.isNotEmpty) bloc.add(AddTextLayer(text));
        break;
      case 'Shapes':
        setState(() => _showShapePicker = true);
        break;
      case 'Draw':
        bloc.add(const DrawModeToggled(true));
        break;
      case 'Undo':
        bloc.add(const UndoRequested());
        break;
      case 'Redo':
        bloc.add(const RedoRequested());
        break;
      case 'Lock':
        final id = bloc.state.selectedLayerId;
        if (id != null) bloc.add(LayerLockToggled(id));
        break;
      default:
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Ye module jald aa raha hai')));
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Positioned.fill(child: EditorCanvas()),
          _MinimalTopBar(onMenuTap: _openToolsMenu),
          const _FloatingLayerControls(),
          Positioned(
            left: 12,
            right: 12,
            bottom: 90,
            child: BlocBuilder<EditorBloc, EditorState>(
              builder: (context, state) {
                if (state.isDrawMode) return const DrawToolbar();

                final matches = state.layers.where((l) => l.id == state.selectedLayerId);
                if (matches.isNotEmpty) {
                  final layer = matches.first;
                  if (layer is TextLayer) return TextLayerToolbar(layer: layer);
                  if (layer is ShapeLayer) return ShapeSelectionToolbar(layer: layer);
                }

                if (_showShapePicker) {
                  return ShapeToolbar(onPicked: () => setState(() => _showShapePicker = false));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MinimalTopBar extends StatelessWidget {
  final VoidCallback onMenuTap;
  const _MinimalTopBar({required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _RoundIconButton(icon: Icons.arrow_back, onTap: () => Navigator.of(context).maybePop()),
            _RoundIconButton(icon: Icons.menu_rounded, onTap: onMenuTap),
          ],
        ),
      ),
    );
  }
}

class _FloatingLayerControls extends StatelessWidget {
  const _FloatingLayerControls();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 12,
      bottom: 24,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _RoundIconButton(
              icon: Icons.dashboard_customize_outlined,
              onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const TemplatePickerSheet(),
              ),
            ),
            const SizedBox(height: 10),
            _RoundIconButton(
              icon: Icons.palette_outlined,
              onTap: () async {
                final result = await showLayerQuickPanel(context: context, type: LayerPanelType.color);
                if (result != null && context.mounted) {
                  context.read<EditorBloc>().add(DrawColorChanged(result as Color));
                }
              },
            ),
            const SizedBox(height: 10),
            _RoundIconButton(
              icon: Icons.line_weight_rounded,
              onTap: () async {
                final result =
                    await showLayerQuickPanel(context: context, type: LayerPanelType.thickness);
                if (result != null && context.mounted) {
                  context.read<EditorBloc>().add(DrawWidthChanged(result as double));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.35),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(10), child: Icon(icon, color: Colors.white, size: 20)),
      ),
    );
  }
}
