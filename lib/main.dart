import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trashsmart/pages/artikel1_page.dart';
import 'package:trashsmart/pages/artikel2_page.dart';
import 'package:trashsmart/pages/artikel3_page.dart';
import 'package:trashsmart/pages/data_profile.dart';
import 'package:trashsmart/pages/home_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/organik_page.dart';
import 'pages/anorganik_page.dart';
import 'pages/b3_page.dart';
import 'pages/kertas_page.dart';
import 'pages/residu_page.dart';
import 'pages/welcome_page.dart';
import 'pages/trash_learning_page.dart';
import 'pages/trash_news_page.dart';
import 'pages/profile_page.dart';
import 'pages/splash_video_page.dart';
import 'pages/admin_panel_page.dart';
import 'pages/refuse_page.dart';
import 'pages/reduce_page.dart';
import 'pages/reuse_page.dart';
import 'pages/recycle_page.dart';

import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jvfufpdtakovwuhkwdff.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp2ZnVmcGR0YWtvdnd1aGt3ZGZmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUyMTAxMDIsImV4cCI6MjA5MDc4NjEwMn0.1ZiNB3pq7XHMW6spn2CBLzofUozSbukMVG2iI8yNZDc',
  );

  // NOTIFICATION
  await NotificationService.initialize();

  // PENGINGAT HARIAN
  await NotificationService.scheduleDailyReminder();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // HALAMAN AWAL
      initialRoute: '/',

      // ROUTES
      routes: {
        '/login': (_) => const LoginPage(),

        // DIGANTI: dari SplashVideoPage menjadi AuthChecker
        '/': (_) => const AuthChecker(),

        '/register': (_) => const RegisterPage(),
        '/home': (_) => const HomePage(),
        '/onboarding': (_) => const OnboardingPage(),
        '/organik': (context) => const OrganikPage(),
        '/anorganik': (context) => const AnorganikPage(),
        '/b3': (context) => const B3Page(),
        '/kertas': (context) => const KertasPage(),
        '/residu': (context) => const ResiduPage(),
        '/welcome': (context) => const WelcomePage(),
        '/learning': (context) => const TrashLearningPage(),
        '/news': (context) => const TrashNewsPage(),
        '/data': (context) => DataProfilePage(
              currentUsername: '',
              currentEmail: '',
            ),
        '/artikel1': (_) => const Artikel1Page(),
        '/artikel2': (_) => const Artikel2Page(),
        '/artikel3': (_) => const Artikel3Page(),
        '/profiles': (_) => const ProfilePage(),
        '/adminpage': (_) => const AdminPage(),
        '/splash': (_) => const SplashVideoPage(),
        '/refuse': (context) => const RefusePage(),
        '/reduce': (context) => const ReducePage(),
        '/reuse': (context) => const ReusePage(),
        '/recycle': (context) => const RecyclePage(),
      },
    );
  }
}

// =====================================================
// AUTH CHECKER
// =====================================================

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  bool loading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    final remember = prefs.getBool('remember_me') ?? false;
    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';

    final supabase = Supabase.instance.client;
    final session = supabase.auth.currentSession;
    final user = supabase.auth.currentUser;

    // Kalau remember me aktif dan session masih ada
    if (remember && session != null && user != null) {
      setState(() {
        isLoggedIn = true;
        loading = false;
      });
      return;
    }

    // Kalau remember me aktif tapi session hilang, login ulang otomatis
    if (remember && email.isNotEmpty && password.isNotEmpty) {
      try {
        final response = await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );

        setState(() {
          isLoggedIn = response.user != null;
          loading = false;
        });
        return;
      } catch (e) {
        await prefs.remove('remember_me');
        await prefs.remove('email');
        await prefs.remove('password');

        await supabase.auth.signOut();
      }
    }

    // Kalau tidak remember me, jangan auto login
    if (!remember && session != null) {
      await supabase.auth.signOut();
    }

    setState(() {
      isLoggedIn = false;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF9F5EC),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (isLoggedIn) {
      return const HomePage();
    }

    return const SplashVideoPage();
  }
}