import 'package:flutter/material.dart';
import 'dart:ui';

/// Modern Transparent Full-screen Text Input with a "New Design" glass effect.
Future<String?> showTextInputSheet(BuildContext context, {String? initialText, Offset? tapPosition}) {
  return showGeneralDialog<String>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Text Input',
    barrierColor: Colors.black.withOpacity(0.15), // Very light dim
    transitionDuration: const Duration(milliseconds: 350),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: child,
        ),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return _TextInputDialog(initialText: initialText, tapPosition: tapPosition);
    },
  );
}

class _TextInputDialog extends StatefulWidget {
  final String? initialText;
  final Offset? tapPosition;
  const _TextInputDialog({this.initialText, this.tapPosition});

  @override
  State<_TextInputDialog> createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<_TextInputDialog> {
  late final TextEditingController _controller = TextEditingController(text: widget.initialText);
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Request focus after a short delay to ensure the keyboard pops up smoothly 
    // during/after the dialog transition.
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    // Exact vertical position from tap
    double topPos = widget.tapPosition?.dy ?? screenHeight / 2 - 50;
    
    // Safety check: ensure it stays above the keyboard
    // Adding extra padding for smooth clearance
    if (topPos > screenHeight - keyboardHeight - 180) {
      topPos = screenHeight - keyboardHeight - 200;
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18), // High quality blur
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // Detect tap on background to finish
            GestureDetector(
              onTap: () => Navigator.of(context).pop(_controller.text.trim()),
              child: Container(color: Colors.transparent),
            ),
            
            // NEW DESIGN: Floating Glass Input Box with Animation
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              top: topPos.clamp(120.0, screenHeight - 100),
              left: 20,
              right: 20,
              child: Material(
                color: Colors.transparent,
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0,
                    shadows: [
                      Shadow(color: Colors.black38, blurRadius: 15, offset: Offset(0, 4)),
                    ],
                  ),
                  maxLines: null,
                  cursorColor: Colors.white,
                  cursorWidth: 3,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) => Navigator.of(context).pop(value.trim()),
                  decoration: InputDecoration(
                    hintText: 'Type here...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.25)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.12), // Premium glass box
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.15), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.15), width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.3), width: 2),
                    ),
                  ),
                ),
              ),
            ),

            // Top Control Bar
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 15,
              right: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white, size: 32),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(_controller.text.trim()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: const Text(
                        'DONE',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
