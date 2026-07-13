import 'package:flutter/material.dart';
import '../../../../core/widgets/common_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Views: 'default', 'loading', 'error', 'empty', 'success'
  String _currentView = 'default';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flexify Widgets'),
        actions: [
          Icon(isDark ? Icons.dark_mode : Icons.light_mode),
          if (_currentView != 'default')
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => setState(() => _currentView = 'default'),
            ),
          const SizedBox(width: 16),
        ],
      ),
      body: _buildBody(theme),
    );
  }

  Widget _buildBody(ThemeData theme) {
    switch (_currentView) {
      case 'loading':
        return const AppLoadingWidget(message: 'Data load ho raha hai...');
      case 'error':
        return AppErrorView(
          message: 'Server se sampark nahi ho paya.',
          onRetry: () => setState(() => _currentView = 'loading'),
        );
      case 'empty':
        return AppEmptyView(
          message: 'Yahan abhi koi records nahi hain.',
          onRefresh: () => setState(() => _currentView = 'default'),
        );
      case 'success':
        return AppSuccessView(
          message: 'Aapka kaam safaltapoorvak ho gaya!',
          onDone: () => setState(() => _currentView = 'default'),
        );
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Centralized UI States',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _demoButton('Loading', 'loading', Colors.blue),
                  _demoButton('Error', 'error', Colors.red),
                  _demoButton('Empty', 'empty', Colors.grey),
                  _demoButton('Success', 'success', Colors.green),
                ],
              ),
            ],
          ),
        );
    }
  }

  Widget _demoButton(String label, String view, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: () => setState(() => _currentView = view),
      child: Text(label),
    );
  }
}
