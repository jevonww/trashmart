import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // REGISTER
  Future<String?> register(
    String email,
    String password,
    String username,
  ) async {
    try {
      // SIGN UP
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        return "Gagal membuat akun";
      }

      // INSERT PROFILE
      await supabase.from('profiles').insert({
        'id': user.id,
        'username': username,
        'email': email,
        'password': password,
      });

      return null;

    } on PostgrestException catch (e) {
      return e.message;

    } on AuthException catch (e) {
      return e.message;

    } catch (e) {
      return "Terjadi kesalahan: $e";
    }
  }

  // LOGIN
  Future<String?> login(
    String email,
    String password,
  ) async {
    try {
      final response =
          await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return "Email atau password salah";
      }

      return null;

    } catch (e) {
      return "Email atau password salah";
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}