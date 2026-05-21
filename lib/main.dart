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
    url:
        'https://jvfufpdtakovwuhkwdff.supabase.co',

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
        '/': (_) => const AuthChecker(),

        '/login': (_) =>
            const LoginPage(),

        '/register': (_) =>
            const RegisterPage(),

        '/home': (_) =>
            const HomePage(),

        '/onboarding': (_) =>
            const OnboardingPage(),

        '/organik': (_) =>
            const OrganikPage(),

        '/anorganik': (_) =>
            const AnorganikPage(),

        '/b3': (_) =>
            const B3Page(),

        '/kertas': (_) =>
            const KertasPage(),

        '/residu': (_) =>
            const ResiduPage(),

        '/welcome': (_) =>
            const WelcomePage(),

        '/learning': (_) =>
            const TrashLearningPage(),

        '/news': (_) =>
            const TrashNewsPage(),

        '/data': (_) =>
            DataProfilePage(
              currentUsername: '',
              currentEmail: '',
            ),

        '/artikel1': (_) =>
            const Artikel1Page(),

        '/artikel2': (_) =>
            const Artikel2Page(),

        '/artikel3': (_) =>
            const Artikel3Page(),

        '/profiles': (_) =>
            const ProfilePage(),

        '/adminpage': (_) =>
            const AdminPage(),

        '/splash': (_) =>
            const SplashVideoPage(),

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
  State<AuthChecker> createState() =>
      _AuthCheckerState();
}

class _AuthCheckerState
    extends State<AuthChecker> {

  bool loading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs =
        await SharedPreferences.getInstance();

    final remember =
        prefs.getBool('remember_me') ?? false;

    final session =
        Supabase.instance.client.auth.currentSession;

    // JIKA TIDAK CENTANG REMEMBER ME
    if (!remember && session != null) {
      await Supabase.instance.client.auth.signOut();
    }

    setState(() {
      isLoggedIn =
          remember &&
          Supabase.instance.client.auth.currentSession !=
              null;

      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // LOADING
    if (loading) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    // SUDAH LOGIN
    if (isLoggedIn) {
      return const HomePage();
    }

    // BELUM LOGIN
    return const SplashVideoPage();
  }
}