import 'package:flutter/material.dart';

import 'home_page.dart';
import 'splash_screen.dart';

class RouteGenerator {
  static const String homePage = '/homePage';
  static const String splashScreen = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      default:
        throw Exception('Route not found');
    }
  }
}
