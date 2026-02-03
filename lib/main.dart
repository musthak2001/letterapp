import 'package:flutter/material.dart';
import 'package:letterapp/pages/profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart';
import 'screens/homescreen.dart';
import 'screens/output_screen.dart';

import 'pages/login_page.dart';
import 'package:letterapp/pages/register_page.dart';
import 'screens/testapi.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load .env file
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
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
        '/profile_screen': (context) => const ProfilePage(),

      }, // Only splash screen for now
    );
  }
}
