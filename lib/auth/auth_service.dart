import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService  {

  //This connects your app to Supabase
  final SupabaseClient _supabase = Supabase.instance.client;

  //signIn with email and password

  Future<AuthResponse> SignInwithEmailPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  //signUp with email and password

  Future<AuthResponse> SignUpwithEmailPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

  //signOut
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  //Get User Email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
