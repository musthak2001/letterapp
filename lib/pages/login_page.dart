import 'package:flutter/material.dart';
import 'package:letterapp/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  //showing an error below line
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async{
    final email = _emailController.text;
    final password = _passwordController.text;

    try{
      await authService.SignInwithEmailPassword(email, password);
    }
    //showing errorcurly braces
    catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error : @e")));
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
            
          ),


          //password
          TextField(
            controller: _passwordController,
          ),

          ElevatedButton(onPressed: login, child: Text("Login"))


        ],
      ),
    );
  }
}
