import 'package:flutter/material.dart';
import 'package:flexwala/core/di/injection_container.dart';
import 'package:flexwala/core/navigation/app_router.dart';
import 'package:flexwala/core/storage/secure_storage_service.dart';
import 'package:flexwala/core/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    
    final storage = sl<SecureStorageService>();
    final isLoggedIn = await storage.isLoggedIn;

    if (mounted) {
      if (isLoggedIn) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.brandGradientDiagonal,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/logopng.png',
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Flexwala',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Design Your Dreams',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 60),
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
