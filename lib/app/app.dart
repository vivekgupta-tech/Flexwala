// app/app.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexify/core/di/injection_container.dart';
import 'package:flexify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flexify/features/auth/presentation/pages/login_page.dart';
import 'package:flexify/features/home/presentation/home_page.dart';
import 'package:flexify/features/posters/presentation/pages/poster_detail_screen.dart';
import 'package:flexify/features/menu/presentation/pages/category_screen.dart';
import 'package:flexify/features/menu/presentation/pages/menu_screen.dart';
import 'package:flexify/features/menu/presentation/pages/business_category_screen.dart';
import 'event_bus.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<String>? _sessionSub;

  @override
  void initState() {
    super.initState();
    _sessionSub = AppEventBus.instance.stream.listen((event) {
      if (event == 'session_expired') {
        navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }

  @override
  void dispose() {
    _sessionSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flexify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF1D4ED8),
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: const Color(0xFF1D4ED8),
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
        initialRoute: '/menu',
        routes: {
          // '/login': (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
          '/poster_detail': (_) => const PosterDetailScreen(),
          '/menu': (_) => const MenuScreen(),
          '/category': (_) => const CategoryScreen(),
          '/business_category': (_) => const BusinessCategoryScreen(),
        },
      ),
    );
  }
}
