import 'package:flutter/material.dart';
import 'package:news_app_route/core/routing/page_route_name.dart';
import 'package:news_app_route/features/home/ui/home_screen.dart';
import 'package:news_app_route/features/search/ui/search_screen.dart';

import '../../features/splash/ui/splash_screen.dart';
import '../../presentaion/home/home_view.dart';
import '../../presentaion/home/taps/home_screen.dart';


class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        {
          return MaterialPageRoute(builder: (context) => SplashScreen(),
              settings: settings
          );
        }
        case Routes.home:
        {
          return MaterialPageRoute(builder: (context) => HomeView(),
              settings: settings
          );
        }
        case Routes.search:
        {
          return MaterialPageRoute(builder: (context) => SearchScreen(),
              settings: settings
          );
        }
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(
                body: Center(
                  child: Text('No routes defiend for ${settings.name}'),
                ),
              ), // Default route (or error page)
        );
    }
  }
}