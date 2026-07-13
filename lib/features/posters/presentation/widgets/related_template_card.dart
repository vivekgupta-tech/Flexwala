import 'package:flutter/material.dart';

import 'package:flexify/core/models/template_model.dart';

/// Reusable dark poster thumbnail card used in "Related Templates" row.
class RelatedTemplateCard extends StatelessWidget {
  final TemplateModel data;
  final VoidCallback? onTap;

  const RelatedTemplateCard({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 118,
        height: 168,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              data.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.black),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.78),
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: data.titleLines
                    .map(
                      (line) => Text(
                        line.text,
                        style: TextStyle(
                          color: line.color,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          height: 1.05,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Positioned(
              left: 8,
              bottom: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: data.buttonColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'JOIN NOW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
