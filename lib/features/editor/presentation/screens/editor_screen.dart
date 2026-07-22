import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flexwala/features/editor/domain/entities/shape_layer.dart';
import 'package:flexwala/features/editor/domain/entities/text_layer.dart';
import 'package:flexwala/features/editor/presentation/bloc/editor_bloc.dart';
import 'package:flexwala/features/editor/presentation/bloc/editor_event.dart';
import 'package:flexwala/features/editor/presentation/bloc/editor_state.dart';
import 'package:flexwala/features/editor/presentation/widgets/canvas/editor_canvas.dart';
import 'package:flexwala/features/editor/presentation/widgets/panels/layer_quick_panel.dart';
import 'package:flexwala/features/editor/presentation/widgets/sheets/element_picker_sheet.dart';
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
      case 'Fonts':
        final selectedId = bloc.state.selectedLayerId;
        final selectedLayer = bloc.state.layers.where((l) => l.id == selectedId).firstOrNull;

        if (selectedLayer is TextLayer) {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) => BlocProvider.value(
              value: bloc,
              child: _TextStyleSheet(layerId: selectedLayer.id),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pehle kisi text layer ko select karein')),
          );
        }
        break;
      case 'Shapes':
        setState(() => _showShapePicker = true);
        break;
      case 'Elements':
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => BlocProvider.value(
            value: bloc,
            child: const ElementPickerSheet(),
          ),
        );
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
      case 'Photo':
        final picker = ImagePicker();
        final image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          bloc.add(AddShapeLayer(ShapeKind.rectangle, dx: 100, dy: 100, imagePath: image.path));
        }
        break;
      case 'Background':
        final picker = ImagePicker();
        final image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          bloc.add(BackgroundImageChanged(image.path, isAsset: false));
        }
        break;
      case 'Lock':
        final id = bloc.state.selectedLayerId;
        if (id != null) bloc.add(LayerLockToggled(id));
        break;
      case 'Export':
        bloc.add(const SaveImageRequested());
        break;
      default:
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ye module jald aa raha hai')),
          );
        }
    }
  }

  Future<void> _handlePop() async {
    final bool? shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Save changes?', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Do you want to save your progress before leaving?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Discard', style: TextStyle(color: Colors.redAccent)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<EditorBloc>().add(const SaveImageRequested());
              Navigator.pop(context, false);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (shouldDiscard == true && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handlePop();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: BlocListener<EditorBloc, EditorState>(
          listenWhen: (p, c) => p.saveStatus != c.saveStatus,
          listener: (context, state) {
            if (state.saveStatus == SaveStatus.saving) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saving HD Image...'), duration: Duration(seconds: 1)),
              );
            } else if (state.saveStatus == SaveStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Image saved to gallery! ✅')),
              );
            } else if (state.saveStatus == SaveStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to save image ❌')),
              );
            }
          },
          child: Stack(
            children: [
            const Positioned.fill(
              child: Center(child: EditorCanvas()),
            ),
            _MinimalTopBar(
              onMenuTap: _openToolsMenu,
              onBackTap: _handlePop,
            ),
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
      ),
    ));
  }
}

class _MinimalTopBar extends StatelessWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onBackTap;
  const _MinimalTopBar({required this.onMenuTap, required this.onBackTap});

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
              onTap: onBackTap,
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
            const SizedBox(height: 10),
            _RoundIconButton(
              icon: Icons.edit_note_rounded,
              onTap: () => context.read<EditorBloc>().add(const DrawModeToggled(true)),
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

class _TextStyleSheet extends StatelessWidget {
  final String layerId;
  const _TextStyleSheet({required this.layerId});

  @override
  Widget build(BuildContext context) {
    final fonts = ['Roboto', 'Sans Serif', 'Monospace', 'Serif', 'Cursive'];

    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) {
        final layer = state.layers.firstWhere((l) => l.id == layerId) as TextLayer;
        final bloc = context.read<EditorBloc>();

        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Text Style',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StyleToggle(
                    icon: Icons.format_bold_rounded,
                    isActive: layer.fontWeight == FontWeight.bold,
                    onTap: () => bloc.add(TextStyleChanged(
                      id: layer.id,
                      fontWeight: layer.fontWeight == FontWeight.bold ? FontWeight.normal : FontWeight.bold,
                    )),
                  ),
                  _StyleToggle(
                    icon: Icons.format_italic_rounded,
                    isActive: layer.fontStyle == FontStyle.italic,
                    onTap: () => bloc.add(TextStyleChanged(
                      id: layer.id,
                      fontStyle: layer.fontStyle == FontStyle.italic ? FontStyle.normal : FontStyle.italic,
                    )),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Fonts', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: ListView.separated(
                  itemCount: fonts.length,
                  separatorBuilder: (_, __) => const Divider(color: Colors.white10, height: 1),
                  itemBuilder: (context, index) {
                    final f = fonts[index];
                    final isSelected = layer.fontFamily == f;
                    return ListTile(
                      onTap: () => bloc.add(TextStyleChanged(id: layer.id, fontFamily: f)),
                      title: Text(f, style: TextStyle(fontFamily: f, color: Colors.white)),
                      trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.blueAccent) : null,
                      contentPadding: EdgeInsets.zero,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StyleToggle extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _StyleToggle({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? Colors.blueAccent : Colors.white10,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
