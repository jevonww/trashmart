import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bottom_nav.dart';
import 'trash_learning_page.dart';
import 'trash_news_page.dart';
import 'profile_page.dart';
import 'daily_login_page.dart';
import 'reward_page.dart';

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

  late final PageController pageController;

  final GlobalKey<_HomeMainContentState> homeMainKey =
      GlobalKey<_HomeMainContentState>();

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: selectedIndex);

    pages = [
      HomeMainContent(key: homeMainKey, onChangeTab: changeTab),
      const TrashLearningPage(),
      TrashNewsPage(onChangeTab: changeTab),
      ProfilePage(onChangeTab: changeTab),
    ];
  }

  void changeTab(int idx) {
    setState(() {
      selectedIndex = idx;
    });

    pageController.animateToPage(
      idx,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );

    if (idx == 0) {
      homeMainKey.currentState?.loadUser();
    }
  }

  void onPageChanged(int idx) {
    setState(() {
      selectedIndex = idx;
    });

    if (idx == 0) {
      homeMainKey.currentState?.loadUser();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5EC),
      body: Stack(
        children: [
          SafeArea(
            child: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              physics: const BouncingScrollPhysics(),
              children: pages,
            ),
          ),
          Positioned(
            bottom: 20,
            right: -300,
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
  int totalPoints = 0;
  bool isLoadingUser = false;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  int parsePoint(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  String getRewardTitle(int points) {
    if (points >= 150) return "Eco Master";
    if (points >= 100) return "Green Hero";
    if (points >= 50) return "Eco Learner";
    return "Smart Rookie";
  }

  String getNextRewardTitle(int points) {
    if (points >= 150) return "Level Maksimal";
    if (points >= 100) return "Eco Master";
    if (points >= 50) return "Green Hero";
    return "Eco Learner";
  }

  int getNextLevelMin(int points) {
    if (points >= 150) return 150;
    if (points >= 100) return 150;
    if (points >= 50) return 100;
    return 50;
  }

  double getRewardProgress(int points) {
    if (points >= 150) {
      return 1.0;
    }

    return (points / 150).clamp(0.0, 1.0).toDouble();
  }

  Future<void> loadUser() async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      if (user == null) return;

      if (mounted) {
        setState(() {
          isLoadingUser = true;
        });
      }

      final data = await supabase
          .from('profiles')
          .select('username, points')
          .eq('id', user.id)
          .maybeSingle();

      if (!mounted) return;

      setState(() {
        username = data?['username'] ?? "User";
        totalPoints = parsePoint(data?['points']);
        isLoadingUser = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoadingUser = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memuat data user: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> openDailyLoginPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DailyLoginPage(),
      ),
    );

    loadUser();
  }

  Future<void> openRewardPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RewardPage(),
      ),
    );

    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // HEADER
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
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
                  const SizedBox(height: 10),
                  _pointBadge(),
                ],
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                if (widget.onChangeTab != null) {
                  widget.onChangeTab!(3);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/logo.png'),
                ),
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
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3F4F44).withOpacity(0.24),
                blurRadius: 18,
                spreadRadius: 1,
                offset: const Offset(0, 9),
              ),
            ],
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
                  elevation: 0,
                ),
                onPressed: openDailyLoginPage,
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
          height: 185,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
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
        const Text(
          "TrashNews",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 205,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
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

        const SizedBox(height: 22),

        // REWARD SECTION
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Reward Kamu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            GestureDetector(
              onTap: openRewardPage,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF3F4F44).withOpacity(0.10),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Text(
                      "Detail",
                      style: TextStyle(
                        color: Color(0xFF3F4F44),
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 3),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF3F4F44),
                      size: 12,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        _rewardCard(),

        const SizedBox(height: 80),
      ],
    );
  }

  Widget _pointBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF3F4F44),
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3F4F44).withOpacity(0.22),
            blurRadius: 14,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.stars_rounded,
            color: Color(0xFFFFD166),
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            isLoadingUser ? 'Memuat Point...' : '$totalPoints Point',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _rewardCard() {
    final rewardTitle = getRewardTitle(totalPoints);
    final nextRewardTitle = getNextRewardTitle(totalPoints);
    final nextLevelMin = getNextLevelMin(totalPoints);
    final progress = getRewardProgress(totalPoints);

    return GestureDetector(
      onTap: openRewardPage,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2F3B25),
              Color(0xFF587048),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3F4F44).withOpacity(0.28),
              blurRadius: 22,
              spreadRadius: 1,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFC107).withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.star_rounded,
                    color: Color(0xFF3F4F44),
                    size: 32,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Poin",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        isLoadingUser ? "..." : "$totalPoints",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    rewardTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 9,
                backgroundColor: Colors.white.withOpacity(0.20),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFFFC107),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  rewardTitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  totalPoints >= 150
                      ? "Level tertinggi tercapai"
                      : "Menuju $nextRewardTitle • $nextLevelMin poin",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                image,
                width: 58,
                height: 58,
                fit: BoxFit.contain,
              ),
            ),
          ),
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
        margin: const EdgeInsets.only(right: 12, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.85),
              blurRadius: 4,
              offset: const Offset(-2, -2),
            ),
          ],
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
        margin: const EdgeInsets.only(right: 12, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.85),
              blurRadius: 4,
              offset: const Offset(-2, -2),
            ),
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