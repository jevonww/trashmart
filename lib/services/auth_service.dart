import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // REGISTER
  Future<String?> register(
    String email,
    String password,
    String username, {
    String? emailRedirectTo,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: emailRedirectTo,
        data: {
          'username': username,
        },
      );

      final user = response.user;

      if (user == null) {
        return "Gagal membuat akun";
      }

      await supabase.from('profiles').upsert({
        'id': user.id,
        'username': username,
        'email': email,

        // Kolom password tetap diisi agar tidak NULL.
        // Password asli tetap aman di Supabase Auth.
        'password': password,

        'points': 0,
      });

      return null;
    } on AuthException catch (e) {
      final message = e.message.toLowerCase();

      if (message.contains('security purposes') ||
          message.contains('only request this after')) {
        return "Terlalu cepat meminta email konfirmasi. Tunggu sebentar lalu coba lagi.";
      }

      if (message.contains('already registered') ||
          message.contains('user already registered')) {
        return "Email ini sudah terdaftar. Coba login atau gunakan email lain.";
      }

      if (message.contains('invalid email')) {
        return "Format email tidak valid.";
      }

      if (message.contains('password')) {
        return "Password terlalu lemah atau tidak valid.";
      }

      return e.message;
    } on PostgrestException catch (e) {
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
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return "Email atau password salah";
      }

      return null;
    } on AuthException catch (e) {
      final message = e.message.toLowerCase();

      if (message.contains('email not confirmed')) {
        return "Email belum dikonfirmasi. Cek email kamu dulu.";
      }

      return "Email atau password salah";
    } catch (e) {
      return "Email atau password salah";
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}