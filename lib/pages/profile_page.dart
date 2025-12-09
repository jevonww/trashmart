import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'data_profile.dart';
import 'reset_password_page.dart';

class ProfilePage extends StatefulWidget {
  final ValueChanged<int>? onChangeTab;
  const ProfilePage({super.key, this.onChangeTab});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "";
  String email = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() => isLoading = false);
      return;
    }

    final data = await supabase
        .from('profiles')
        .select('username, email')
        .eq('id', user.id)
        .maybeSingle();

    setState(() {
      username = data?['username'] ?? "User";
      email = data?['email'] ?? user.email ?? "email@unknown.com";
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E8),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // ================= HEADER =================
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD1E2C4),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/logo_tanpanama.png", width: 50),
                              const SizedBox(width: 6),
                              const Text(
                                "TRASHSMART",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // BACK BUTTON
                      Positioned(
                        left: 20,
                        top: 40,
                        child: GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(context, '/home'),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.arrow_back, size: 24),
                          ),
                        ),
                      ),

                      // FOTO PROFIL (default)
                      Positioned(
                        bottom: -55,
                        left: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("assets/logo.png"),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 70),

                  // ================= USERNAME =================
                  Text(
                    username,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),

                  const SizedBox(height: 6),

                  // ================= EMAIL =================
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1E2C4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(email),
                  ),

                  const SizedBox(height: 24),

                  // ================= MENU BOX =================
                  Container(
                    width: 320,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // === EDIT PROFILE FIXED ===
                        menuItem(Icons.edit, "Edit Profile", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DataProfilePage(
                                currentUsername: username,
                                currentEmail: email,
                              ),
                            ),
                          ).then((_) => loadProfile());
                        }),

                        // === RESET PASSWORD ===
                        menuItem(Icons.lock_reset, "Reset Password", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ResetPasswordPage()),
                          );
                        }),

                        menuItem(Icons.bookmark, "Save Artikel", () {}),

                        menuItem(Icons.logout, "Logout", () => _handleLogout(context)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // =============== LOGOUT ===============

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Batal')),
          TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Logout')),
        ],
      ),
    );

    if (confirmed != true) return;

    await Supabase.instance.client.auth.signOut();

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  // =============== MENU ITEM WIDGET ===============

  Widget menuItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 22, color: Colors.black87),
                const SizedBox(width: 12),
                Text(title, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
