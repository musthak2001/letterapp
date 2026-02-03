import 'package:letterapp/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //showing an error below line
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  void signup() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmpassword = _confirmpasswordController.text;

    if (password != confirmpassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      await authService.SignUpwithEmailPassword(email, password);

      // ✅ Navigate using pushNamed
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login_screen');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          //email
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
          ),

          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter password",
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
            ),
          ),

          //password
          TextField(
            controller: _confirmpasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Confirm Password",
              hintText: "Re-enter password",
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(),
            ),
          ),

          ElevatedButton(onPressed: signup, child: Text("Register")),
        ],
      ),
    );
  }
}
