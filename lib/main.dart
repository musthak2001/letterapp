import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/homescreen.dart';
import 'screens/output_screen.dart';


import 'screens/testapi.dart';


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
        '/TestApp': (context) => const TestApp(),
        '/output_screen' : (context) => const MyWidget()
        
      }, // Only splash screen for now
    );
  }
}
