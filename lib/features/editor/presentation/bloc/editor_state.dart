import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/layer.dart';
import '../../domain/entities/stroke.dart';
import '../../domain/entities/template.dart';

enum TemplatesStatus { initial, loading, loaded, error }

enum SaveStatus { initial, saving, success, error }

class EditorState extends Equatable {
  /// EditorCanvas isi key se RepaintBoundary banata hai — HD export
  /// isi boundary.toImage(pixelRatio: 4) se hoga.
  final GlobalKey canvasKey;
  final String? backgroundUrl;
  final bool isAssetBackground;
  final List<Layer> layers;
  final String? selectedLayerId;
  final List<List<Layer>> undoStack;
  final List<List<Layer>> redoStack;
  final TemplatesStatus templatesStatus;
  final List<EditorTemplate> templates;
  final SaveStatus saveStatus;

  // Freehand drawing
  final List<Stroke> strokes;
  final Stroke? currentStroke;
  final bool isDrawMode;
  final DrawTool activeDrawTool;
  final Color activeDrawColor;
  final double activeDrawWidth;

  const EditorState({
    required this.canvasKey,
    this.backgroundUrl,
    this.isAssetBackground = false,
    this.layers = const [],
    this.selectedLayerId,
    this.undoStack = const [],
    this.redoStack = const [],
    this.templatesStatus = TemplatesStatus.initial,
    this.templates = const [],
    this.strokes = const [],
    this.currentStroke,
    this.isDrawMode = false,
    this.activeDrawTool = DrawTool.pen,
    this.activeDrawColor = Colors.black,
    this.activeDrawWidth = 4,
    this.saveStatus = SaveStatus.initial,
  });

  EditorState copyWith({
    String? backgroundUrl,
    bool? isAssetBackground,
    List<Layer>? layers,
    String? selectedLayerId,
    bool clearSelection = false,
    List<List<Layer>>? undoStack,
    List<List<Layer>>? redoStack,
    TemplatesStatus? templatesStatus,
    List<EditorTemplate>? templates,
    List<Stroke>? strokes,
    Stroke? currentStroke,
    bool clearCurrentStroke = false,
    bool? isDrawMode,
    DrawTool? activeDrawTool,
    Color? activeDrawColor,
    double? activeDrawWidth,
    SaveStatus? saveStatus,
  }) {
    return EditorState(
      canvasKey: canvasKey,
      backgroundUrl: backgroundUrl ?? this.backgroundUrl,
      isAssetBackground: isAssetBackground ?? this.isAssetBackground,
      layers: layers ?? this.layers,
      selectedLayerId: clearSelection ? null : (selectedLayerId ?? this.selectedLayerId),
      undoStack: undoStack ?? this.undoStack,
      redoStack: redoStack ?? this.redoStack,
      templatesStatus: templatesStatus ?? this.templatesStatus,
      templates: templates ?? this.templates,
      strokes: strokes ?? this.strokes,
      currentStroke: clearCurrentStroke ? null : (currentStroke ?? this.currentStroke),
      isDrawMode: isDrawMode ?? this.isDrawMode,
      activeDrawTool: activeDrawTool ?? this.activeDrawTool,
      activeDrawColor: activeDrawColor ?? this.activeDrawColor,
      activeDrawWidth: activeDrawWidth ?? this.activeDrawWidth,
      saveStatus: saveStatus ?? this.saveStatus,
    );
  }

  @override
  List<Object?> get props => [
        backgroundUrl,
        isAssetBackground,
        layers,
        selectedLayerId,
        undoStack.length,
        redoStack.length,
        templatesStatus,
        templates,
        strokes.length,
        currentStroke,
        isDrawMode,
        activeDrawTool,
        activeDrawColor,
        activeDrawWidth,
        saveStatus,
      ];
}
