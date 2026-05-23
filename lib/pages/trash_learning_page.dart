import 'package:flutter/material.dart';

import 'package:trashsmart/pages/organik_page.dart';
import 'package:trashsmart/pages/anorganik_page.dart';
import 'package:trashsmart/pages/b3_page.dart';
import 'package:trashsmart/pages/kertas_page.dart';
import 'package:trashsmart/pages/residu_page.dart';

class TrashLearningPage extends StatelessWidget {
  const TrashLearningPage({super.key});

  // COLOR PALETTE
  static const Color darkOlive = Color(0xFF414E2B);
  static const Color brownOlive = Color(0xFF5E4A14);
  static const Color softGreen = Color(0xFF8CB66B);
  static const Color cream = Color(0xFFF5F1E8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "TrashLearning",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: darkOlive,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Pelajari jenis sampah dengan mudah ♻️",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: darkOlive,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // HERO CARD
              Container(
                height: 280,
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [softGreen, darkOlive],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(34),
                ),

                child: Stack(
                  children: [
                    Positioned(
                      top: -20,
                      right: -20,
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: -30,
                      left: -20,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.18),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Kategori Populer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 22),

                              const Text(
                                "Sampah\nOrganik",
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.1,
                                ),
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                "Mudah terurai alami dan dapat dijadikan kompos.",
                                style: TextStyle(
                                  color: Colors.white,
                                  height: 1.5,
                                ),
                              ),

                              const Spacer(),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const OrganikPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text(
                                        "Pelajari",
                                        style: TextStyle(
                                          color: darkOlive,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        color: darkOlive,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 8),

                        Image.asset(
                          "assets/organik.png",
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 34),

              // TITLE
              const Text(
                "Kategori Sampah",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkOlive,
                ),
              ),

              const SizedBox(height: 20),

              // HORIZONTAL CARD
              SizedBox(
                height: 230,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _trashCard(
                      context,
                      title: "Organik",
                      subtitle: "Mudah terurai alami",
                      image: "assets/organik.png",
                      color: const Color(0xFFDFF2DD),
                      page: const OrganikPage(),
                    ),

                    _trashCard(
                      context,
                      title: "Anorganik",
                      subtitle: "Dapat didaur ulang",
                      image: "assets/anorganik.png",
                      color: const Color(0xFFFFF0C9),
                      page: const AnorganikPage(),
                    ),

                    _trashCard(
                      context,
                      title: "B3",
                      subtitle: "Berbahaya & beracun",
                      image: "assets/b3.png",
                      color: const Color(0xFFFFD9D9),
                      page: const B3Page(),
                    ),

                    _trashCard(
                      context,
                      title: "Kertas",
                      subtitle: "Bisa digunakan ulang",
                      image: "assets/kertas.png",
                      color: const Color(0xFFDDEBFF),
                      page: const KertasPage(),
                    ),

                    _trashCard(
                      context,
                      title: "Residu",
                      subtitle: "Sulit diolah",
                      image: "assets/residu.png",
                      color: const Color(0xFFE5E5E5),
                      page: const ResiduPage(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // INFO CARD
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Row(
                  children: const [
                    Text("🌍", style: TextStyle(fontSize: 46)),

                    SizedBox(width: 16),

                    Expanded(
                      child: Text(
                        "Yuk mulai memilah sampah dari sekarang untuk menjaga bumi tetap bersih dan sehat.",
                        style: TextStyle(height: 1.6, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trashCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String image,
    required Color color,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },

      child: Container(
        width: 175,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(32),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Stack(
          children: [
            Positioned(
              top: -20,
              right: -10,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.25),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(image, height: 80, fit: BoxFit.contain),
                ),

                const SizedBox(height: 12),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: darkOlive,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black54,
                    height: 1.3,
                    fontSize: 13,
                  ),
                ),

                const Spacer(),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: darkOlive,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
