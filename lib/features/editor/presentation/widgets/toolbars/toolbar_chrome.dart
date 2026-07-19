import 'package:flutter/material.dart';

/// Text/Shape selection toolbars aur Draw toolbar sab isi pill-shaped
/// container ko reuse karte hain — canvas ke bilkul upar tairta hua.
class ToolbarChrome extends StatelessWidget {
  final List<Widget> children;
  const ToolbarChrome({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.55),
          borderRadius: BorderRadius.circular(30),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < children.length; i++) ...[
                if (i != 0) const SizedBox(width: 14),
                children[i],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ToolbarIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;
  const ToolbarIcon({super.key, required this.icon, required this.onTap, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: 20, color: isActive ? Colors.blueAccent : Colors.white),
    );
  }
}
