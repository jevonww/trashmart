import 'package:flutter/material.dart';

class ResiduPage extends StatelessWidget {
  const ResiduPage({super.key});

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
                      "assets/residu.png",
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
                "Sampah Residu",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3E472D),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Bagian MATERI MATERI
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
               "Pengertian:\n"
              "Sampah residu adalah sisa pemilahan sampah yang tidak termasuk kategori organik, anorganik daur ulang (kertas, logam, kaca), atau B3. Residu sulit/tidak dapat didaur ulang dan biasanya dikirim ke tempat pembuangan akhir (TPA).\n\n"

              "Contoh Sampah Residu:\n"
              "• Lampu pijar & LED yang sudah mati\n"
              "• Cermin pecah yang tidak bisa diperbaiki\n"
              "• Kemasan plastik berlapis/campuran\n"
              "• Plastik tipis & plastik sulit daur ulang\n"
              "• Popok & pembalut bekas\n"
              "• Noda makanan berat pada kemasan\n"
              "• Keramik/porcelain pecah tidak dapat diperbaiki\n"
              "• Kain/tekstil yang rusak\n\n"

              "Ciri-ciri Residu:\n"
              "• Tidak dapat didaur ulang dengan mudah\n"
              "• Kombinasi bahan sulit dipisah\n"
              "• Biaya pemisahan lebih tinggi dari nilai guna\n"
              "• Dapat mencemari jika dibuang sembarangan\n\n"

              "Cara Pengelolaan Praktis:\n"
              "1) Pisahkan → Pastikan benar-benar bukan organik/anorganik daur ulang.\n"
              "2) Bungkus dengan aman → Khususnya untuk benda tajam atau berbahaya.\n"
              "3) Kumpulkan → Masukkan ke wadah residu yang terpisah.\n"
              "4) Serahkan ke bank sampah/pengepul → Mereka akan meneruskan ke TPA dengan cara yang aman.\n\n"

              "Tips Pemilahan:\n"
              "• Residu = sampah yang TIDAK bisa dipisah/didaur ulang.\n"
              "• Jika ragu, tanya ke bank sampah terdekat.\n"
              "• Hindari mencampur residu dengan organik (menimbulkan bau & hama).\n"
              "• Benda tajam/pecah dibungkus kertas/koran sebelum dimasukkan.\n\n"

              "Manfaat Pengelolaan Residu yang Tepat:\n"
              "• Memisahkan residu dari organik → Mengurangi bau & hama di rumah.\n"
              "• Mengalihkan dari TPA → Memperpanjang masa pakai TPA.\n"
              "• Mencegah pencemaran → Residu ditangani dengan cara yang aman.\n"
              "• Mendukung ekonomi sirkular → Barang daur ulang terjaga nilai & fungsinya.\n\n"

              "Langkah praktis mulai sekarang:\n"
              "1) Pahami kategori: Organik ≠ Anorganik daur ulang ≠ Residu.\n"
              "2) Siapkan 3+ wadah pemisahan sampah di rumah.\n"
              "3) Ajari keluarga cara memilah dengan benar.\n"
              "4) Setor residu ke bank sampah/pengepul terdekat.\n\n"
              "Sumber ringkas: panduan 3R (Reduce, Reuse, Recycle) pemerintah, sistem bank sampah nasional, dan best practice pengelolaan sampah rumah tangga.",
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
