import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/verify_otp_page.dart';
import '../../features/home/presentation/home_page_old.dart';
import '../../features/posters/presentation/pages/poster_detail_screen.dart';
import '../../features/menu/presentation/pages/category_screen.dart';
import '../../features/menu/presentation/pages/menu_screen.dart';
import '../../features/sub_category/presentation/pages/sub_category_screen.dart';
import '../../features/template/template_screen.dart';

import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/sub_category/presentation/bloc/sub_category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../di/injection_container.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String verifyOtp = '/verify-otp';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String posterDetail = '/poster_detail';
  static const String menu = '/menu';
  static const String category = '/category';
  static const String subCategory = '/sub_category';
  static const String template = '/template';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case verifyOtp:
        final mobile = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => VerifyOtpPage(mobile: mobile));
      case home:
        return MaterialPageRoute(builder: (_) => const HomePageOld());
      case profile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<ProfileBloc>(),
            child: const ProfilePage(),
          ),
        );
      case posterDetail:
        return MaterialPageRoute(builder: (_) => const PosterDetailScreen());
      case menu:
        return MaterialPageRoute(builder: (_) => const MenuScreen());
      case category:
        return MaterialPageRoute(builder: (_) => const CategoryScreen());
      case subCategory:
        final categoryId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SubCategoryBloc>()..add(FetchSubCategories()),
            child: SubCategoryScreen(categoryId: categoryId),
          ),
        );
      case template:
        final subCategoryName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => TemplateScreen(subCategoryName: subCategoryName),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
