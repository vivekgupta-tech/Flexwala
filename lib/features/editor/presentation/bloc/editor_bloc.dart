import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/shape_layer.dart';
import '../../domain/entities/stroke.dart';
import '../../domain/entities/text_layer.dart';
import '../../domain/repositories/template_repository.dart';
import 'editor_event.dart';
import 'editor_state.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  final TemplateRepository templateRepository;
  int _autoId = 0;

  EditorBloc({required this.templateRepository})
      : super(EditorState(canvasKey: GlobalKey())) {
    on<LoadTemplates>(_onLoadTemplates);
    on<TemplateSelected>(_onTemplateSelected);
    on<LayerSelected>((event, emit) => emit(state.copyWith(
          selectedLayerId: event.id,
          clearSelection: event.id == null,
        )));
    on<LayerTransformed>(_onLayerTransformed);
    on<LayerLockToggled>(_onLayerLockToggled);
    on<LayerDeleted>(_onLayerDeleted);
    on<AddTextLayer>(_onAddTextLayer);
    on<TextStyleChanged>(_onTextStyleChanged);
    on<AddShapeLayer>(_onAddShapeLayer);
    on<ShapeStyleChanged>(_onShapeStyleChanged);
    on<DrawModeToggled>((event, emit) => emit(state.copyWith(isDrawMode: event.isOn)));
    on<DrawToolSelected>((event, emit) => emit(state.copyWith(activeDrawTool: event.tool)));
    on<DrawColorChanged>((event, emit) => emit(state.copyWith(activeDrawColor: event.color)));
    on<DrawWidthChanged>((event, emit) => emit(state.copyWith(activeDrawWidth: event.width)));
    on<StrokeStarted>(_onStrokeStarted);
    on<StrokePointAdded>(_onStrokePointAdded);
    on<StrokeEnded>(_onStrokeEnded);
    on<UndoRequested>(_onUndo);
    on<RedoRequested>(_onRedo);
  }

  String _newId() => 'layer_${_autoId++}_${DateTime.now().microsecondsSinceEpoch}';

  Future<void> _onLoadTemplates(LoadTemplates event, Emitter<EditorState> emit) async {
    emit(state.copyWith(templatesStatus: TemplatesStatus.loading));
    try {
      final templates = await templateRepository.getTemplates();
      emit(state.copyWith(templatesStatus: TemplatesStatus.loaded, templates: templates));
    } catch (_) {
      emit(state.copyWith(templatesStatus: TemplatesStatus.error));
    }
  }

  void _onTemplateSelected(TemplateSelected event, Emitter<EditorState> emit) {
    emit(state.copyWith(
      backgroundUrl: event.template.backgroundUrl,
      isAssetBackground: event.template.isAsset,
      layers: const [],
    ));
  }

  void _pushUndo(Emitter<EditorState> emit) {
    emit(state.copyWith(undoStack: [...state.undoStack, state.layers], redoStack: const []));
  }

  void _onLayerTransformed(LayerTransformed event, Emitter<EditorState> emit) {
    final layers = state.layers.map((layer) {
      if (layer.id != event.id) return layer;
      return layer.withTransform(
        dx: event.dx,
        dy: event.dy,
        scale: event.scale,
        rotation: event.rotation,
      );
    }).toList();
    emit(state.copyWith(layers: layers));
  }

  void _onLayerLockToggled(LayerLockToggled event, Emitter<EditorState> emit) {
    final layers = state.layers.map((layer) {
      if (layer.id != event.id) return layer;
      return layer.withLock(!layer.isLocked);
    }).toList();
    emit(state.copyWith(layers: layers));
  }

  void _onLayerDeleted(LayerDeleted event, Emitter<EditorState> emit) {
    _pushUndo(emit);
    emit(state.copyWith(
      layers: state.layers.where((l) => l.id != event.id).toList(),
      clearSelection: true,
    ));
  }

  void _onAddTextLayer(AddTextLayer event, Emitter<EditorState> emit) {
    _pushUndo(emit);
    final layer = TextLayer(id: _newId(), text: event.text, dx: 100, dy: 200);
    emit(state.copyWith(layers: [...state.layers, layer], selectedLayerId: layer.id));
  }

  void _onTextStyleChanged(TextStyleChanged event, Emitter<EditorState> emit) {
    final layers = state.layers.map((layer) {
      if (layer.id != event.id || layer is! TextLayer) return layer;
      return layer.copyWith(
        text: event.text,
        fontFamily: event.fontFamily,
        fontSize: event.fontSize,
        fontWeight: event.fontWeight,
        color: event.color,
        align: event.align,
      );
    }).toList();
    emit(state.copyWith(layers: layers));
  }

  void _onAddShapeLayer(AddShapeLayer event, Emitter<EditorState> emit) {
    _pushUndo(emit);
    final layer = ShapeLayer(id: _newId(), kind: event.kind, dx: 110, dy: 220);
    emit(state.copyWith(layers: [...state.layers, layer], selectedLayerId: layer.id));
  }

  void _onShapeStyleChanged(ShapeStyleChanged event, Emitter<EditorState> emit) {
    final layers = state.layers.map((layer) {
      if (layer.id != event.id || layer is! ShapeLayer) return layer;
      return layer.copyWith(
        fillColor: event.fillColor,
        borderColor: event.borderColor,
        borderWidth: event.borderWidth,
        imagePath: event.imagePath,
      );
    }).toList();
    emit(state.copyWith(layers: layers));
  }

  void _onStrokeStarted(StrokeStarted event, Emitter<EditorState> emit) {
    emit(state.copyWith(
      currentStroke: Stroke(
        points: [event.point],
        color: state.activeDrawColor,
        width: state.activeDrawWidth,
        tool: state.activeDrawTool,
      ),
    ));
  }

  void _onStrokePointAdded(StrokePointAdded event, Emitter<EditorState> emit) {
    final current = state.currentStroke;
    if (current == null) return;
    emit(state.copyWith(currentStroke: current.copyWith(points: [...current.points, event.point])));
  }

  void _onStrokeEnded(StrokeEnded event, Emitter<EditorState> emit) {
    final current = state.currentStroke;
    if (current == null) return;
    emit(state.copyWith(strokes: [...state.strokes, current], clearCurrentStroke: true));
  }

  void _onUndo(UndoRequested event, Emitter<EditorState> emit) {
    if (state.undoStack.isEmpty) return;
    final previous = state.undoStack.last;
    emit(state.copyWith(
      layers: previous,
      undoStack: state.undoStack.sublist(0, state.undoStack.length - 1),
      redoStack: [...state.redoStack, state.layers],
    ));
  }

  void _onRedo(RedoRequested event, Emitter<EditorState> emit) {
    if (state.redoStack.isEmpty) return;
    final next = state.redoStack.last;
    emit(state.copyWith(
      layers: next,
      redoStack: state.redoStack.sublist(0, state.redoStack.length - 1),
      undoStack: [...state.undoStack, state.layers],
    ));
  }
}
