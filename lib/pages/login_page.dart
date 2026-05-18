import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'register_page.dart';
import '../services/auth_service.dart';
import '../services/supabase_client.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final auth = AuthService();

  bool rememberMe = false;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    loadRememberMe();
  }

  Future<void> loadRememberMe() async {
    final prefs =
        await SharedPreferences.getInstance();

    final isRemember =
        prefs.getBool('remember_me') ?? false;

    if (isRemember) {
      setState(() {
        rememberMe = true;

        emailController.text =
            prefs.getString('email') ?? '';

        passwordController.text =
            prefs.getString('password') ?? '';
      });
    }
  }

  Future<void> saveRememberMe(
    String email,
    String password,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    if (rememberMe) {
      await prefs.setBool(
          'remember_me', true);

      await prefs.setString(
          'email', email);

      await prefs.setString(
          'password', password);
    } else {
      await prefs.remove(
          'remember_me');

      await prefs.remove('email');

      await prefs.remove('password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF9F5EC),

      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(
                  horizontal: 32),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center,

              children: [
                const SizedBox(height: 40),

                // LOGO
                Image.asset(
                  "assets/logo.png",
                  height: 150,

                  errorBuilder:
                      (context, error,
                              stackTrace) =>
                          const FlutterLogo(
                              size: 90),
                ),

                const SizedBox(height: 20),

                const Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFF3C5122),
                  ),
                ),

                const SizedBox(height: 25),

                // EMAIL FIELD
                TextField(
                  controller:
                      emailController,

                  decoration:
                      InputDecoration(
                    hintText: "Email",

                    prefixIcon:
                        const Icon(Icons
                            .email_outlined),

                    filled: true,
                    fillColor:
                        Colors.white,

                    contentPadding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 20,
                    ),

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                                  30),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // PASSWORD FIELD
                TextField(
                  controller:
                      passwordController,

                  obscureText:
                      hidePassword,

                  decoration:
                      InputDecoration(
                    hintText:
                        "Password",

                    prefixIcon:
                        const Icon(Icons
                            .lock_outline),

                    suffixIcon:
                        IconButton(
                      icon: Icon(
                        hidePassword
                            ? Icons
                                .visibility_off
                            : Icons
                                .visibility,
                      ),

                      onPressed: () {
                        setState(() {
                          hidePassword =
                              !hidePassword;
                        });
                      },
                    ),

                    filled: true,
                    fillColor:
                        Colors.white,

                    contentPadding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 20,
                    ),

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                                  30),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // REMEMBER ME
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,

                      onChanged: (value) {
                        setState(() {
                          rememberMe =
                              value!;
                        });
                      },
                    ),

                    const Text(
                        "Remember Me"),
                  ],
                ),

                const SizedBox(height: 10),

                // LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 48,

                  child: ElevatedButton(
                    style:
                        ElevatedButton
                            .styleFrom(
                      backgroundColor:
                          const Color(
                              0xFF3C5122),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    14),
                      ),
                    ),

                    onPressed: () async {
                      String email =
                          emailController
                              .text
                              .trim();

                      String password =
                          passwordController
                              .text
                              .trim();

                      // ADMIN LOGIN
                      if (email ==
                              "admin" &&
                          password ==
                              "12345") {
                        Navigator
                            .pushReplacementNamed(
                          context,
                          '/adminpage',
                        );

                        return;
                      }

                      // LOGIN SUPABASE
                      final result =
                          await auth.login(
                        email,
                        password,
                      );

                      if (result ==
                          null) {
                        // SAVE REMEMBER ME
                        await saveRememberMe(
                          email,
                          password,
                        );

                        Navigator
                            .pushReplacementNamed(
                          context,
                          '/onboarding',
                        );
                      } else {
                        ScaffoldMessenger
                                .of(context)
                            .showSnackBar(
                          SnackBar(
                            content:
                                Text(result),
                          ),
                        );
                      }
                    },

                    child: const Text(
                      "Masuk",

                      style: TextStyle(
                        fontSize: 16,
                        color:
                            Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // REGISTER
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                  children: [
                    const Text(
                      "Don't have an account?",
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const RegisterPage(),
                          ),
                        );
                      },

                      child:
                          const Text(
                        "Register",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}