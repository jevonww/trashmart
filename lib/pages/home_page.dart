import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bottom_nav.dart';
import 'trash_learning_page.dart';
import 'trash_news_page.dart';
import 'profile_page.dart';

import 'package:trashsmart/services/notification_service.dart';

import 'package:trashsmart/pages/organik_page.dart';
import 'package:trashsmart/pages/anorganik_page.dart';
import 'package:trashsmart/pages/b3_page.dart';
import 'package:trashsmart/pages/kertas_page.dart';
import 'package:trashsmart/pages/residu_page.dart';

import 'refuse_page.dart';
import 'reduce_page.dart';
import 'reuse_page.dart';
import 'recycle_page.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onChangeTab;

  const HomePage({super.key, this.onChangeTab});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      HomeMainContent(onChangeTab: changeTab),
      const TrashLearningPage(),
      TrashNewsPage(onChangeTab: changeTab),
      ProfilePage(onChangeTab: changeTab),
    ];
  }

  void changeTab(int idx) {
    setState(() => selectedIndex = idx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5EC),

      body: Stack(
        children: [
          SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),

              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(0.0, 0.05),
                  end: Offset.zero,
                ).animate(animation);

                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  ),
                );
              },

              child: SizedBox(
                key: ValueKey<int>(selectedIndex),
                child: IndexedStack(index: selectedIndex, children: pages),
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            right: 20,

            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 66, 110, 68),

              onPressed: () {
                Navigator.pushNamed(context, '/chatbot');
              },

              child: const Icon(Icons.chat_bubble_outline, size: 24),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNav(
        currentIndex: selectedIndex,
        onTap: (i) => changeTab(i),
      ),
    );
  }
}

// ================= HOME CONTENT =================

class HomeMainContent extends StatefulWidget {
  final ValueChanged<int>? onChangeTab;

  const HomeMainContent({super.key, this.onChangeTab});

  @override
  State<HomeMainContent> createState() => _HomeMainContentState();
}

class _HomeMainContentState extends State<HomeMainContent> {
  String username = "Smartizen";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final supabase = Supabase.instance.client;

    final user = supabase.auth.currentUser;

    if (user == null) return;

    final data = await supabase
        .from('profiles')
        .select('username')
        .eq('id', user.id)
        .single();

    setState(() {
      username = data['username'] ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),

      children: [
        // HEADER
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Halo, $username!",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  "Yuk, eksplor dan belajar bersama",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),

            const Spacer(),

            GestureDetector(
              onTap: () {
                if (widget.onChangeTab != null) {
                  widget.onChangeTab!(3);
                }
              },

              child: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/logo.png'),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // MENU
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            _menuIcon(
              image: "assets/refuse.png",
              label: "Refuse",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RefusePage()),
                );
              },
            ),

            _menuIcon(
              image: "assets/reduce.png",
              label: "Reduce",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReducePage()),
                );
              },
            ),

            _menuIcon(
              image: "assets/reuse.png",
              label: "Reuse",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReusePage()),
                );
              },
            ),

            _menuIcon(
              image: "assets/recycle.png",
              label: "Recycle",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RecyclePage()),
                );
              },
            ),
          ],
        ),

        const SizedBox(height: 24),

        // REMINDER
        const Text(
          "Pengingat untukmu",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: const Color(0xFF3F4F44),
            borderRadius: BorderRadius.circular(14),
          ),

          child: Row(
            children: [
              const Expanded(
                child: Text(
                  "Sudah buang sampah hari ini?",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF3F4F44),
                ),

                onPressed: () async {
                  await NotificationService.showTestNotification();
                },

                child: const Text("Cek sekarang"),
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        // TRASH LEARNING TITLE
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            const Text(
              "TrashLearning",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            GestureDetector(
              onTap: () {
                if (widget.onChangeTab != null) {
                  widget.onChangeTab!(1);
                }
              },

              child: const Text(
                "Lihat Semua >",
                style: TextStyle(
                  color: Color(0xFF8CB66B),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // LEARNING CARD
        SizedBox(
          height: 180,

          child: ListView(
            scrollDirection: Axis.horizontal,

            children: [
              _learningCard(context, "Sampah Organik", "assets/organik.png"),

              _learningCard(
                context,
                "Sampah Anorganik",
                "assets/anorganik.png",
              ),

              _learningCard(context, "Sampah B3", "assets/b3.png"),

              _learningCard(context, "Sampah Kertas", "assets/kertas.png"),

              _learningCard(context, "Sampah Residu", "assets/residu.png"),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // NEWS
        const Text("TrashNews", style: TextStyle(fontWeight: FontWeight.bold)),

        const SizedBox(height: 8),

        SizedBox(
          height: 200,

          child: ListView(
            scrollDirection: Axis.horizontal,

            children: [
              _newsCard(
                context,
                "Pertemuan bilateral Indonesia - Norwegia bahas solusi sampah plastik",
                "assets/artikel_1.png",
              ),

              _newsCard(
                context,
                "Kelola Sampah Tingkat Lokal, Bank Sampah RW 01 Depok Beroperasi",
                "assets/artikel_2.png",
              ),

              _newsCard(
                context,
                "Pengelolaan Sampah Meningkat di 2025",
                "assets/artikel_3.png",
              ),
            ],
          ),
        ),

        const SizedBox(height: 60),
      ],
    );
  }

  Widget _menuIcon({
    required String image,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Column(
        children: [
          Image.asset(image, width: 58, height: 58, fit: BoxFit.contain),

          const SizedBox(height: 6),

          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF445236),
            ),
          ),
        ],
      ),
    );
  }

  Widget _learningCard(BuildContext context, String title, String asset) {
    return GestureDetector(
      onTap: () {
        Widget page;

        switch (title) {
          case "Sampah Organik":
            page = const OrganikPage();
            break;

          case "Sampah Anorganik":
            page = const AnorganikPage();
            break;

          case "Sampah B3":
            page = const B3Page();
            break;

          case "Sampah Kertas":
            page = const KertasPage();
            break;

          case "Sampah Residu":
            page = const ResiduPage();
            break;

          default:
            page = const TrashLearningPage();
        }

        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },

      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset(asset, width: 80, height: 80, fit: BoxFit.contain),

            const SizedBox(height: 8),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _newsCard(BuildContext context, String title, String imageUrl) {
    return GestureDetector(
      onTap: () {
        if (widget.onChangeTab != null) {
          widget.onChangeTab!(2);
        }
      },

      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 12),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),

          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(0.04), blurRadius: 8),
          ],
        ),

        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),

              child: imageUrl.startsWith('http')
                  ? Image.network(
                      imageUrl,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      imageUrl,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),

            Padding(
              padding: const EdgeInsets.all(8),

              child: Text(title, style: const TextStyle(fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}
