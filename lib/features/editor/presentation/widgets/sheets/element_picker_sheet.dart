import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/editor_bloc.dart';
import '../../bloc/editor_event.dart';

/// Elements/Stickers picker sheet for modern look.
class ElementPickerSheet extends StatelessWidget {
  const ElementPickerSheet({super.key});

  // Example "stickers" or emojis for now. In a real app, these could be asset paths.
  static const _stickers = [
    '🔥', '✨', '⭐', '❤️', '🎉', '🚀', '💡', '🌈', '💎', '🎨', '📸', '🎵',
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Elements',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: _stickers.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Stickers add karne ke liye transparent background wala ShapeLayer use karenge
                        context.read<EditorBloc>().add(AddTextLayer(
                              _stickers[index],
                            ));
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _stickers[index],
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
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
