import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashsmart/pages/reward_page.dart';
import 'package:trashsmart/pages/save_artikel.dart';
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

  final Color darkGreen = const Color(0xFF3F4F44);
  final Color cream = const Color(0xFFF8F3E8);

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

    if (!mounted) return;

    setState(() {
      username = data?['username'] ?? "User";
      email = data?['email'] ?? user.email ?? "email@unknown.com";
      isLoading = false;
    });
  }

  Future<void> _handleLogout(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          backgroundColor: cream,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                    size: 44,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  "Keluar dari Akun?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF26351F),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Kamu akan keluar dari akun TrashSmart. Kamu bisa login kembali kapan saja.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(
                            color: darkGreen,
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "Batal",
                          style: TextStyle(
                            color: darkGreen,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Keluar",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (confirmed != true) return;

    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          backgroundColor: cream,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 26,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: darkGreen,
                  strokeWidth: 3,
                ),
                const SizedBox(width: 18),
                const Text(
                  "Sedang logout...",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Color(0xFF26351F),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove('remember_me');
      await prefs.remove('email');
      await prefs.remove('password');

      await Supabase.instance.client.auth.signOut();

      if (!context.mounted) return;

      Navigator.of(context, rootNavigator: true).pop();

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );
    } catch (e) {
      if (!context.mounted) return;

      Navigator.of(context, rootNavigator: true).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal logout: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget menuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isDanger = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isDanger ? Colors.red : Colors.black87,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDanger ? Colors.red : Colors.black87,
                    fontWeight: isDanger ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isDanger ? Colors.red : Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: darkGreen,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
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
                              Image.asset(
                                "assets/logo_tanpanama.png",
                                width: 50,
                              ),
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

                      Positioned(
                        left: 20,
                        top: 40,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/home');
                          },
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

                      Positioned(
                        bottom: -55,
                        left: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/user_profile.png"),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 70),

                  Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1E2C4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(email),
                  ),

                  const SizedBox(height: 24),

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

                        menuItem(Icons.lock_reset, "Reset Password", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ResetPasswordPage(),
                            ),
                          );
                        }),

                        menuItem(Icons.bookmark, "Save Artikel", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SavedArticlesPage(),
                            ),
                          );
                        }),

                        menuItem(Icons.redeem, "Reward", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RewardPage(),
                            ),
                          );
                        }),

                        menuItem(
                          Icons.logout,
                          "Logout",
                          () => _handleLogout(context),
                          isDanger: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }
}