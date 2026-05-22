import 'package:flutter/material.dart';

import 'organik_page.dart';
import 'anorganik_page.dart';
import 'b3_page.dart';
import 'kertas_page.dart';
import 'residu_page.dart';

class JenisSampahPage extends StatelessWidget {
  const JenisSampahPage({super.key});

  static const Color darkOlive = Color(0xFF414E2B);
  static const Color softGreen = Color(0xFF8CB66B);
  static const Color cream = Color(0xFFF5F1E8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: Container(
                      padding: const EdgeInsets.all(12),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),

                  const SizedBox(width: 16),

                  const Text(
                    "Jenis-Jenis Sampah",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: darkOlive,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const Text(
                "Pelajari berbagai jenis sampah dan cara pengelolaannya.",
                style: TextStyle(color: Colors.black54, height: 1.5),
              ),

              const SizedBox(height: 28),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: .82,

                  children: [
                    _item(
                      context,
                      "Organik",
                      "Mudah terurai",
                      "assets/organik.png",
                      const Color(0xFFDFF2DD),
                      const OrganikPage(),
                    ),

                    _item(
                      context,
                      "Anorganik",
                      "Daur ulang",
                      "assets/anorganik.png",
                      const Color(0xFFFFF0C9),
                      const AnorganikPage(),
                    ),

                    _item(
                      context,
                      "B3",
                      "Berbahaya",
                      "assets/b3.png",
                      const Color(0xFFFFD9D9),
                      const B3Page(),
                    ),

                    _item(
                      context,
                      "Kertas",
                      "Digunakan ulang",
                      "assets/kertas.png",
                      const Color(0xFFDDEBFF),
                      const KertasPage(),
                    ),

                    _item(
                      context,
                      "Residu",
                      "Sulit diolah",
                      "assets/residu.png",
                      const Color(0xFFE5E5E5),
                      const ResiduPage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context,
    String title,
    String subtitle,
    String image,
    Color color,
    Widget page,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },

      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(child: Image.asset(image, height: 90)),

            const Spacer(),

            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: darkOlive,
              ),
            ),

            const SizedBox(height: 6),

            Text(subtitle, style: const TextStyle(color: Colors.black54)),

            const SizedBox(height: 14),

            Container(
              height: 42,
              width: 42,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),

              child: const Icon(Icons.arrow_forward_rounded, color: darkOlive),
            ),
          ],
        ),
      ),
    );
  }
}
