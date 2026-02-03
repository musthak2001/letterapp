import 'package:letterapp/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:letterapp/screens/splash_screen.dart'; // Make sure this import matches your project

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService();

  void logout() async {
    await authService.signOut();

    // Navigate back to SplashScreen and remove all previous routes
    if (!mounted) return; // Check if widget is still in the tree
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SplashScreen()),
      (route) => false, // Removes all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: logout,
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
