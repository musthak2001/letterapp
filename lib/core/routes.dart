import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/homescreen.dart';
import '../screens/output_screen.dart';
import '../screens/testapi.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/profile_page.dart';
import 'route_names.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
        RouteNames.splash: (_) => const SplashScreen(),
        RouteNames.home: (_) => const HomeScreen(),
        RouteNames.login: (_) => const LoginPage(),
        RouteNames.register: (_) => const RegisterPage(),
        RouteNames.profile: (_) => const ProfilePage(),
        RouteNames.output: (_) => const MyWidget(),
        RouteNames.test: (_) => const TestApp(),
      };
}
