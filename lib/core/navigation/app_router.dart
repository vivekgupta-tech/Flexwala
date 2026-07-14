import 'package:flutter/material.dart';
import 'package:flexify/features/home/presentation/home_page.dart';
import 'package:flexify/features/posters/presentation/pages/poster_detail_screen.dart';
import 'package:flexify/features/menu/presentation/pages/category_screen.dart';
import 'package:flexify/features/menu/presentation/pages/menu_screen.dart';
import 'package:flexify/features/menu/presentation/pages/business_category_screen.dart';
import 'package:flexify/features/business_category/presentation/business_category_page.dart';

class AppRoutes {
  static const String home = '/home';
  static const String posterDetail = '/poster_detail';
  static const String menu = '/menu';
  static const String category = '/category';
  static const String businessCategory = '/business_category';
  static const String businessCategoryPage = '/business_category_page';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case posterDetail:
        return MaterialPageRoute(builder: (_) => const PosterDetailScreen());
      case menu:
        return MaterialPageRoute(builder: (_) => const MenuScreen());
      case category:
        return MaterialPageRoute(builder: (_) => const CategoryScreen());
      case businessCategory:
        return MaterialPageRoute(builder: (_) => const BusinessCategoryScreen());
      case businessCategoryPage:
        return MaterialPageRoute(builder: (_) => const BusinessCategoryPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
