import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexwala/features/editor/domain/entities/shape_layer.dart';
import 'package:flexwala/features/editor/domain/entities/text_layer.dart';
import 'package:flexwala/features/editor/presentation/bloc/editor_bloc.dart';
import 'package:flexwala/features/editor/presentation/bloc/editor_event.dart';
import 'package:flexwala/features/editor/presentation/bloc/editor_state.dart';
import 'package:flexwala/features/editor/presentation/widgets/canvas/editor_canvas.dart';
import 'package:flexwala/features/editor/presentation/widgets/panels/layer_quick_panel.dart';
import 'package:flexwala/features/editor/presentation/widgets/sheets/template_picker_sheet.dart';
import 'package:flexwala/features/editor/presentation/widgets/sheets/text_input_sheet.dart';
import 'package:flexwala/features/editor/presentation/widgets/sheets/tools_bottom_sheet.dart';
import 'package:flexwala/features/editor/presentation/widgets/toolbars/draw_toolbar.dart';
import 'package:flexwala/features/editor/presentation/widgets/toolbars/shape_selection_toolbar.dart';
import 'package:flexwala/features/editor/presentation/widgets/toolbars/shape_toolbar.dart';
import 'package:flexwala/features/editor/presentation/widgets/toolbars/TextLayerToolbar.dart';

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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ye module jald aa raha hai')),
          );
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
          const Positioned.fill(
            child: Center(child: EditorCanvas()),
          ),
          _MinimalTopBar(onMenuTap: _openToolsMenu),
          BlocBuilder<EditorBloc, EditorState>(
            builder: (context, state) {
              Widget? toolbar;
              if (state.isDrawMode) {
                toolbar = const DrawToolbar();
              } else {
                final matches = state.layers.where((l) => l.id == state.selectedLayerId);
                if (matches.isNotEmpty) {
                  final layer = matches.first;
                  if (layer is TextLayer) {
                    toolbar = TextLayerToolbar(layer: layer);
                  } else if (layer is ShapeLayer) {
                    toolbar = ShapeSelectionToolbar(layer: layer);
                  }
                } else if (_showShapePicker) {
                  toolbar = ShapeToolbar(
                    onPicked: () => setState(() => _showShapePicker = false),
                  );
                }
              }

              final showFloatingControls = toolbar == null;
              return Stack(
                children: [
                  if (toolbar != null)
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 90,
                      child: toolbar,
                    ),
                  if (showFloatingControls) const _FloatingLayerControls(),
                ],
              );
            },
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
            _RoundIconButton(
              icon: Icons.arrow_back,
              onTap: () => Navigator.of(context).maybePop(),
            ),
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
        top: false,
        left: false,
        right: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _RoundIconButton(
              icon: Icons.dashboard_customize_outlined,
              onTap: () {
                final bloc = context.read<EditorBloc>();
                // Sheet kholne se pehle load event bhej rahe hain
                bloc.add(const LoadTemplates()); 
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => BlocProvider.value(
                    value: bloc,
                    child: const TemplatePickerSheet(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            _RoundIconButton(
              icon: Icons.palette_outlined,
              onTap: () async {
                final bloc = context.read<EditorBloc>();
                final result = await showLayerQuickPanel(
                  context: context,
                  type: LayerPanelType.color,
                  initialValue: bloc.state.activeDrawColor,
                );
                if (result != null && context.mounted) {
                  bloc.add(DrawColorChanged(result as Color));
                }
              },
            ),
            const SizedBox(height: 10),
            _RoundIconButton(
              icon: Icons.line_weight_rounded,
              onTap: () async {
                final bloc = context.read<EditorBloc>();
                final result = await showLayerQuickPanel(
                  context: context,
                  type: LayerPanelType.thickness,
                  initialValue: bloc.state.activeDrawWidth,
                );
                if (result != null && context.mounted) {
                  bloc.add(DrawWidthChanged(result as double));
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
