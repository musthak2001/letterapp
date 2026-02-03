import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart';
import 'screens/homescreen.dart';
import 'screens/output_screen.dart';

import 'pages/login_page.dart';
import 'pages/profile_page.dart';
import 'pages/register_page.dart';

import 'screens/testapi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://laqgpzqdgbtefjwqxbqf.supabase.co',
    anonKey: 'sb_publishable_qPPjxfNLkMFMT8KMUB9Rng_0__fXJfv',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/homeScreen': (context) => const HomeScreen(),

        '/TestApp': (context) => const TestApp(),
        '/output_screen': (context) => const MyWidget(),

        '/login_screen': (context) => const LoginPage(),
        '/register_screen': (context) => const RegisterPage(),
      }, // Only splash screen for now
    );
  }
}
