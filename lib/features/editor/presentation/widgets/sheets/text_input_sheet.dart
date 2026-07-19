import 'package:flutter/material.dart';

/// Text add/edit dono ke liye same sheet — [initialText] diya to edit
/// mode, warna naya text add hoga.
Future<String?> showTextInputSheet(BuildContext context, {String? initialText}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _TextInputSheet(initialText: initialText),
  );
}

class _TextInputSheet extends StatefulWidget {
  final String? initialText;
  const _TextInputSheet({this.initialText});

  @override
  State<_TextInputSheet> createState() => _TextInputSheetState();
}

class _TextInputSheetState extends State<_TextInputSheet> {
  late final TextEditingController _controller = TextEditingController(text: widget.initialText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  maxLines: 3,
                  minLines: 1,
                  decoration: const InputDecoration(hintText: 'Yaha text likho...', border: InputBorder.none),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.check_circle, color: Colors.blueAccent),
                onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
