import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jvfufpdtakovwuhkwdff.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp2ZnVmcGR0YWtvdnd1aGt3ZGZmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUyMTAxMDIsImV4cCI6MjA5MDc4NjEwMn0.1ZiNB3pq7XHMW6spn2CBLzofUozSbukMVG2iI8yNZDc',
  );

  await NotificationService.initialize();
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

      // ROUTES LIST
      routes: {
        '/login': (_) => const LoginPage(),
        '/': (_) => const SplashVideoPage(),
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
        '/artikel1': (context) => const Artikel1Page(),
        '/artikel2': (context) => const Artikel2Page(),
        '/artikel3': (context) => const Artikel3Page(),
        '/profiles': (context) => const ProfilePage(),
        '/adminpage': (context) => const AdminPage(),
      },
    );
  }
}