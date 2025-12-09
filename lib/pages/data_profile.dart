import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataProfilePage extends StatefulWidget {
  final String currentUsername;
  final String currentEmail;

  const DataProfilePage({
    super.key,
    required this.currentUsername,
    required this.currentEmail,
  });

  @override
  State<DataProfilePage> createState() => _DataProfilePageState();
}

class _DataProfilePageState extends State<DataProfilePage> {
  final usernameC = TextEditingController();
  final emailC = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();
    usernameC.text = widget.currentUsername;
    emailC.text = widget.currentEmail;
  }

  // ======================================================
  //                   SAVE PROFILE FIXED
  // ======================================================
  Future<void> saveProfile() async {
    final supa = Supabase.instance.client;
    final user = supa.auth.currentUser;
    if (user == null) {
      _snack("User belum terautentikasi");
      return;
    }

    final uid = user.id;
    final newEmail = emailC.text.trim();
    final newUsername = usernameC.text.trim();

    setState(() => loading = true);
    try {
      // Jika email berubah, update di Auth Supabase dulu
      if (newEmail != widget.currentEmail) {
        final res = await supa.auth.updateUser(UserAttributes(email: newEmail));
        if (res.user == null) {
          _snack("Gagal memperbarui email (Auth)");
          setState(() => loading = false);
          return;
        }
      }

      // Update tabel profiles (username + email)
      await supa.from('profiles').update({
        "username": newUsername,
        "email": newEmail,
      }).eq("id", uid);

      _snack("Profil berhasil diperbarui!");
      if (context.mounted) Navigator.pop(context, true);
    } catch (e) {
      _snack("Terjadi kesalahan: $e");
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  // SnackBar Helper
  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F3E8),
        elevation: 0,
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            _field("Username", usernameC),
            const SizedBox(height: 18),
            _field("Email", emailC),
            const SizedBox(height: 26),

            GestureDetector(
              onTap: loading ? null : saveProfile,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Simpan",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  

  Widget _field(String label, TextEditingController c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFD1E2C4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
        ),
      ),
    );
  }
}
