import 'package:flutter/material.dart';

class AppSuccessView extends StatelessWidget {
  final String message;
  final VoidCallback? onDone;

  const AppSuccessView({
    super.key,
    required this.message,
    this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              'Success!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (onDone != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onDone,
                child: const Text('Continue'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

