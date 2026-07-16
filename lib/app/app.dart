// app/app.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexwala/core/di/injection_container.dart';
import 'package:flexwala/core/navigation/app_router.dart';
import 'package:flexwala/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flexwala/core/theme/app_theme.dart';
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
        title: 'Flexwala',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}

