import 'package:flutter/material.dart';

enum LayerPanelType { color, thickness }

Future<dynamic> showLayerQuickPanel({
  required BuildContext context,
  required LayerPanelType type,
  dynamic initialValue,
}) {
  return showModalBottomSheet<dynamic>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _LayerQuickPanel(type: type, initialValue: initialValue),
  );
}

class _LayerQuickPanel extends StatefulWidget {
  final LayerPanelType type;
  final dynamic initialValue;
  const _LayerQuickPanel({required this.type, this.initialValue});

  @override
  State<_LayerQuickPanel> createState() => _LayerQuickPanelState();
}

class _LayerQuickPanelState extends State<_LayerQuickPanel> {
  static const _colors = [
    Colors.black, Colors.white, Colors.red, Colors.pink, Colors.purple,
    Colors.deepPurple, Colors.indigo, Colors.blue, Colors.lightBlue,
    Colors.cyan, Colors.teal, Colors.green, Colors.lightGreen, Colors.lime,
    Colors.yellow, Colors.amber, Colors.orange, Colors.deepOrange, Colors.brown, Colors.grey,
  ];
  
  late double _thickness;

  @override
  void initState() {
    super.initState();
    _thickness = (widget.initialValue is num) ? widget.initialValue.toDouble() : 4.0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 16,
        right: 16,
      ),
      child: Material(
        color: Colors.white,
        elevation: 10,
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            // Handle
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.type == LayerPanelType.color ? 'रंग निवडा' : 'जाडी निवडा',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: widget.type == LayerPanelType.color ? _colorGrid() : _thicknessControls(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _colorGrid() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _colors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final isSelected = widget.initialValue == _colors[i];
          return GestureDetector(
            onTap: () => Navigator.of(context).pop(_colors[i]),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: _colors[i],
                radius: 18,
                child: _colors[i] == Colors.white
                    ? const Icon(Icons.circle_outlined, size: 16, color: Colors.black12)
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _thicknessControls() {
    return Column(
      children: [
        // Live Preview of thickness
        Container(
          height: 30,
          alignment: Alignment.center,
          child: Container(
            width: double.infinity,
            height: _thickness.clamp(1, 25),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.line_weight_rounded, size: 20, color: Colors.grey),
            Expanded(
              child: Slider(
                value: _thickness,
                min: 1,
                max: 50,
                divisions: 49,
                onChanged: (v) => setState(() => _thickness = v),
                onChangeEnd: (v) => Navigator.of(context).pop(v),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${_thickness.toInt()}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
