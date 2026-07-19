import 'package:flutter/material.dart';

/// Ye do panels reference (Smart Whiteboard) ke color-row aur
/// thickness-row ka replacement hain — hamesha dikhne ke bajaye ab
/// sirf apna icon dabane par khulte hain. Color panel Color return
/// karta hai, thickness panel double — dono `Future<dynamic>` hain
/// isliye caller apni jagah pe cast kar leta hai.
enum LayerPanelType { color, thickness }

Future<dynamic> showLayerQuickPanel({
  required BuildContext context,
  required LayerPanelType type,
}) {
  return showModalBottomSheet<dynamic>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => _LayerQuickPanel(type: type),
  );
}

class _LayerQuickPanel extends StatefulWidget {
  final LayerPanelType type;
  const _LayerQuickPanel({required this.type});

  @override
  State<_LayerQuickPanel> createState() => _LayerQuickPanelState();
}

class _LayerQuickPanelState extends State<_LayerQuickPanel> {
  static const _colors = [
    Colors.black,
    Colors.white,
    Colors.grey,
    Colors.red,
    Colors.deepOrange,
    Colors.amber,
    Colors.green,
    Colors.blue,
  ];
  double _thickness = 4;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4)),
          ],
        ),
        child: widget.type == LayerPanelType.color ? _colorRow(context) : _thicknessRow(context),
      ),
    );
  }

  Widget _colorRow(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _colors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, i) => GestureDetector(
          onTap: () => Navigator.of(context).pop(_colors[i]),
          child: CircleAvatar(
            backgroundColor: _colors[i],
            radius: 16,
            child: _colors[i] == Colors.white
                ? const Icon(Icons.circle_outlined, size: 14, color: Colors.black26)
                : null,
          ),
        ),
      ),
    );
  }

  Widget _thicknessRow(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle, size: 6 + _thickness / 2),
        Expanded(
          child: Slider(
            value: _thickness,
            min: 1,
            max: 30,
            onChanged: (v) => setState(() => _thickness = v),
            onChangeEnd: (v) => Navigator.of(context).pop(v),
          ),
        ),
        SizedBox(width: 28, child: Text('${_thickness.toInt()}')),
      ],
    );
  }
}
