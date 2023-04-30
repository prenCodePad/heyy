import 'package:flutter/material.dart';

import '../pages/pages.dart';
import 'package:heyy/routing/routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var path = settings.name;
    print("hii ${path}");
    if (settings.name == '/') path = Routes.loginPage;
    switch (path) {
      case Routes.loginPage:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const LoginPage(), settings: settings);
      case Routes.homePage:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const MyHomePage(title: "Navigated Homepage"), settings: settings);
      case Routes.otpPage:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const LoginPage(), settings: settings);
      case Routes.userSetupPage:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const LoginPage(), settings: settings);
      default:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const ErrorPage(), settings: settings);
    }
  }
}
