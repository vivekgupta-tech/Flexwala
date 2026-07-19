import 'package:flutter/material.dart';

/// App bar ke single menu icon se ye open hota hai — saare tool
/// categories (Text, Draw, Shapes, Elements, Photo, Background, Undo,
/// Redo, Lock, Export) yahi ek jagah rakhe hain taaki screen par
/// hamesha koi icon clutter na dikhe.
class ToolsBottomSheet extends StatelessWidget {
  const ToolsBottomSheet({super.key});

  static const _categories = [
    _ToolCategory('Text', Icons.text_fields_rounded),
    _ToolCategory('Draw', Icons.edit_outlined),
    _ToolCategory('Shapes', Icons.category_outlined),
    _ToolCategory('Elements', Icons.emoji_emotions_outlined),
    _ToolCategory('Photo', Icons.image_outlined),
    _ToolCategory('Background', Icons.wallpaper_outlined),
    _ToolCategory('Undo', Icons.undo_rounded),
    _ToolCategory('Redo', Icons.redo_rounded),
    _ToolCategory('Lock', Icons.lock_outline_rounded),
    _ToolCategory('Export', Icons.ios_share_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.42,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return _CategoryTile(item: _categories[index]);
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

class _ToolCategory {
  final String label;
  final IconData icon;
  const _ToolCategory(this.label, this.icon);
}

class _CategoryTile extends StatelessWidget {
  final _ToolCategory item;
  const _CategoryTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      // Yaha se result pop hoke editor_screen me category ke hisaab se
      // agla toolbar/sheet open karwaya ja sakta hai.
      onTap: () => Navigator.of(context).pop(item.label),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 26),
            const SizedBox(height: 8),
            Text(item.label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
