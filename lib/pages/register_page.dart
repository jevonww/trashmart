import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool loading = false;

  final auth = AuthService();

  static const String redirectTo = 'trashsmart://auth-callback/';

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool isEmailFormatValid(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
    );

    return emailRegex.hasMatch(email);
  }

  Future<void> showCustomPopup({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required String message,
    String buttonText = "Oke",
    VoidCallback? onButtonPressed,
  }) async {
    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFFF9F5EC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
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
                    color: iconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 46,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF26351F),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3C5122),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);

                      if (onButtonPressed != null) {
                        onButtonPressed();
                      }
                    },
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showWarningPopup({
    required String title,
    required String message,
  }) async {
    await showCustomPopup(
      icon: Icons.warning_amber_rounded,
      iconColor: Colors.orange,
      iconBackground: Colors.orange.shade100,
      title: title,
      message: message,
    );
  }

  Future<void> showErrorPopup({
    required String title,
    required String message,
  }) async {
    await showCustomPopup(
      icon: Icons.error_outline_rounded,
      iconColor: Colors.red,
      iconBackground: Colors.red.shade100,
      title: title,
      message: message,
    );
  }

  Future<void> showRegisterSuccessDialog() async {
    await showCustomPopup(
      icon: Icons.mark_email_read_rounded,
      iconColor: const Color(0xFF3C5122),
      iconBackground: const Color(0xFFD1E2C4),
      title: "Registrasi Berhasil",
      message:
          "Akun berhasil dibuat.\nSilakan buka email kamu lalu klik tombol konfirmasi untuk mengaktifkan akun TrashSmart.",
      buttonText: "Ke Halaman Login",
      onButtonPressed: () {
        Navigator.pushReplacementNamed(context, '/login');
      },
    );
  }

  Future<void> handleRegister() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim().toLowerCase();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty &&
        email.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty) {
      await showWarningPopup(
        title: "Form Masih Kosong",
        message: "Semua kolom wajib diisi sebelum membuat akun.",
      );
      return;
    }

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      await showWarningPopup(
        title: "Data Belum Lengkap",
        message:
            "Pastikan username, email, password, dan konfirmasi password sudah diisi semua.",
      );
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      await showWarningPopup(
        title: "Email Tidak Valid",
        message:
            "Masukkan email yang benar. Contoh format yang benar: nama@gmail.com",
      );
      return;
    }

    if (!email.endsWith('@gmail.com')) {
      await showWarningPopup(
        title: "Gunakan Email Gmail",
        message:
            "Untuk saat ini email harus menggunakan akun Gmail dengan format @gmail.com.",
      );
      return;
    }

    if (!isEmailFormatValid(email)) {
      await showWarningPopup(
        title: "Format Gmail Salah",
        message:
            "Email tidak boleh memakai spasi atau karakter aneh. Contoh yang benar: nama@gmail.com",
      );
      return;
    }

    if (password.length < 6) {
      await showWarningPopup(
        title: "Password Terlalu Pendek",
        message: "Password minimal harus berisi 6 karakter.",
      );
      return;
    }

    if (password != confirmPassword) {
      await showWarningPopup(
        title: "Password Tidak Cocok",
        message:
            "Password dan konfirmasi password harus sama. Coba cek lagi ya.",
      );
      return;
    }

    setState(() {
      loading = true;
    });

    final result = await auth.register(
      email,
      password,
      username,
      emailRedirectTo: redirectTo,
    );

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    if (result == null) {
      await showRegisterSuccessDialog();
    } else {
      await showErrorPopup(
        title: "Registrasi Gagal",
        message: result,
      );
    }
  }

  InputDecoration inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.08),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Color(0xFF3C5122),
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5EC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                Image.asset(
                  "assets/logo.png",
                  height: 150,
                ),

                const SizedBox(height: 20),

                const Text(
                  "REGISTER",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3C5122),
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  "Please enter your details",
                  style: TextStyle(color: Colors.black54),
                ),

                const SizedBox(height: 25),

                TextField(
                  controller: usernameController,
                  textInputAction: TextInputAction.next,
                  decoration: inputDecoration(
                    hintText: "Username",
                    prefixIcon: Icons.person_outline,
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: inputDecoration(
                    hintText: "Email",
                    prefixIcon: Icons.email_outlined,
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  textInputAction: TextInputAction.next,
                  decoration: inputDecoration(
                    hintText: "Password",
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: confirmPasswordController,
                  obscureText: hideConfirmPassword,
                  textInputAction: TextInputAction.done,
                  decoration: inputDecoration(
                    hintText: "Confirm Password",
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      icon: Icon(
                        hideConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          hideConfirmPassword = !hideConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3C5122),
                      disabledBackgroundColor:
                          const Color(0xFF3C5122).withOpacity(0.55),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: loading ? null : handleRegister,
                    child: loading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.4,
                            ),
                          )
                        : const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: loading
                      ? null
                      : () {
                          Navigator.pushReplacementNamed(
                            context,
                            '/login',
                          );
                        },
                  child: const Text(
                    "Back to Login",
                    style: TextStyle(
                      color: Color(0xFF3C5122),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}