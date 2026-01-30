import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/homescreen.dart';

void main() {
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
        '/LoadingPage': (context) => const LoadingScreen(),
      }, // Only splash screen for now
    );
  }
}
