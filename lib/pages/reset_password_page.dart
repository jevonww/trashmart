import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _oldC = TextEditingController();
  final _newC = TextEditingController();
  final _confirmC = TextEditingController();

  bool _loading = false;
  bool _hideOld = true;
  bool _hideNew = true;
  bool _hideConfirm = true;

  @override
  void dispose() {
    _oldC.dispose();
    _newC.dispose();
    _confirmC.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      _showSnack("User belum login");
      return;
    }

    final oldPass = _oldC.text.trim();
    final newPass = _newC.text.trim();
    final confirm = _confirmC.text.trim();

    if (oldPass.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      _showSnack("Isi semua field");
      return;
    }
    if (newPass.length < 6) {
      _showSnack("Password baru minimal 6 karakter");
      return;
    }
    if (newPass != confirm) {
      _showSnack("Password baru dan konfirmasi tidak cocok");
      return;
    }

    setState(() => _loading = true);

    try {
      // Re-authenticate: sign in with email + old password to verify
      final signInResp = await supabase.auth.signInWithPassword(
        email: user.email!,
        password: oldPass,
      );

      // If sign-in failed, throw
      final signedUser = signInResp.user;
      if (signedUser == null) {
        throw "Password lama salah";
      }

      // If re-auth OK, update password
      await supabase.auth.updateUser(
        UserAttributes(password: newPass),
      );

      // Success
      if (mounted) {
        _showSnack("Password berhasil diubah");
        Navigator.pop(context);
      }
    } catch (e) {
      // Friendly message
      final msg = (e is String) ? e : "Gagal mengubah password";
      _showSnack(msg);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showSnack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F3E8),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
        title: const Text(
          "Reset Password",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Masukkan password lama untuk verifikasi, lalu isi password baru.",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 24),

            // OLD PASSWORD
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD1E2C4),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _oldC,
                obscureText: _hideOld,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Password lama",
                  suffixIcon: IconButton(
                    icon: Icon(_hideOld ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _hideOld = !_hideOld),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // NEW PASSWORD
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD1E2C4),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _newC,
                obscureText: _hideNew,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Password baru",
                  suffixIcon: IconButton(
                    icon: Icon(_hideNew ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _hideNew = !_hideNew),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // CONFIRM PASSWORD
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD1E2C4),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _confirmC,
                obscureText: _hideConfirm,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Konfirmasi password",
                  suffixIcon: IconButton(
                    icon: Icon(_hideConfirm ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _hideConfirm = !_hideConfirm),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // BUTTON
            GestureDetector(
              onTap: _loading ? null : _handleReset,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: _loading ? Colors.grey : const Color(0xFF86A873),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 6, offset: const Offset(0,3)),
                  ],
                ),
                child: Center(
                  child: _loading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text("Ubah Password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
