import 'package:flutter/material.dart';

class AnorganikPage extends StatelessWidget {
  const AnorganikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5EC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Background card
                Container(
                  height: 340,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3E472D),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),

                // Tombol back
                Positioned(
                  top: 45,
                  left: 15,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),

                // Ornamen daun kanan atas
                Positioned(
                  top: 40,
                  right: 25,
                  child: Image.asset(
                    "assets/ornamen_1.png",
                    width: 55,
                    fit: BoxFit.contain,
                  ),
                ),

                // Ornamen daun kiri bawah
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Image.asset(
                    "assets/ornamen_2.png",
                    width: 65,
                    fit: BoxFit.contain,
                  ),
                ),

                // Gambar Tempat Sampah
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/anorganik.png",
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Sampah Anorganik",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3E472D),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Pengertian:\n"
              "Sampah anorganik adalah limbah yang berasal dari bahan non-hidup yang sulit atau tidak dapat terurai secara alami. Contoh: plastik, logam, kaca, keramik, styrofoam.\n\n"

              "Contoh Sampah Anorganik:\n"
              "• Plastik (tas, botol, kemasan, mainan plastik)\n"
              "• Logam (kaleng, kawat, paku, besi tua)\n"
              "• Kaca (botol, gelas pecah, cermin)\n"
              "• Styrofoam & foam plastik\n"
              "• Keramik & tembikar pecah\n\n"

              "Ciri-ciri:\n"
              "• Sulit/tidak dapat membusuk secara alami\n"
              "• Daya tahan lama (bertahan puluhan tahun)\n"
              "• Dapat mencemari lingkungan jika tidak dikelola\n"
              "• Bisa didaur ulang menjadi produk baru\n\n"

              "Cara Pengelolaan Praktis:\n"
              "1) Plastik → Pisahkan berdasarkan jenis & warna, cuci, keringkan, kirim ke bank sampah/pengepul.\n"
              "2) Logam → Kumpulkan & jual ke pengepul besi untuk didaur ulang.\n"
              "3) Kaca → Hati-hati saat menangani, bungkus dengan kertas, kirim ke pengumpulan kaca.\n"
              "4) Styrofoam → Jangan bakar, kumpulkan & kirim ke tempat yang menerima untuk didaur ulang.\n\n"

              "Tips Pemilahan & Penyimpanan:\n"
              "• Pisahkan anorganik dari organik sejak awal di rumah.\n"
              "• Cuci kemasan plastik/kaleng sebelum menyimpan.\n"
              "• Kompres plastik agar hemat tempat.\n"
              "• Simpan di wadah terpisah yang mudah diangkut.\n\n"

              "Manfaat Mengelola Sampah Anorganik:\n"
              "• Mengurangi pencemaran lingkungan (khususnya plastik)\n"
              "• Menghemat sumber daya alam (daur ulang lebih hemat energi)\n"
              "• Mendapat penghasilan tambahan dari penjualan sampah anorganik\n"
              "• Mencegah kerusakan ekosistem laut dari plastik\n\n"

              "Langkah praktis mulai sekarang:\n"
              "1) Siapkan wadah terpisah untuk anorganik.\n"
              "2) Ajak keluarga memilah sampah anorganik.\n"
              "3) Kumpulkan & bawa ke bank sampah/pengepul terdekat.\n"
              "4) Gunakan tas/botol reusable untuk mengurangi plastik sekali pakai.\n\n"
              "Sumber ringkas: panduan pengelolaan sampah nasional, tips daur ulang plastik, dan program bank sampah lokal.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3E472D),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
