import 'package:flutter/material.dart';

class OrganikPage extends StatelessWidget {
  const OrganikPage({super.key});

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
                      "assets/organik.png",
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
                "Sampah Organik",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3E472D),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Materi lengkap Sampah Organik
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Pengertian:\n"
                "Sampah organik adalah sisa bahan yang berasal dari makhluk hidup yang dapat terurai secara alami oleh mikroorganisme. Contoh: sisa makanan, kulit buah, sayuran, daun, ranting, ampas kopi, kulit telur.\n\n"

                "Contoh Sampah Organik:\n"
                "• Sisa buah dan sayuran\n"
                "• Sisa makanan (nasi, lauk)\n"
                "• Daun kering, ranting kecil\n"
                "• Ampas kopi/teh, kulit telur\n\n"

                "Ciri-ciri:\n"
                "• Mudah membusuk dan berbau jika tidak dikelola\n"
                "• Tekstur lembek atau rapuh\n"
                "• Menarik serangga dan hewan pemakan sampah\n\n"

                "Cara Pengelolaan Praktis:\n"
                "1) Kompos Aerobik — campur sampah basah dengan bahan kering (daun/serbuk) dan aduk berkala untuk oksigenasi.\n"
                "2) Vermikompos — gunakan cacing tanah untuk mempercepat penguraian menjadi pupuk.\n"
                "3) Bokashi — fermentasi cepat dengan starter, cocok untuk sisa makanan berminyak.\n\n"

                "Tips Pemilahan & Penyimpanan:\n"
                "• Pisahkan organik dari anorganik sejak di rumah.\n"
                "• Simpan sisa basah dalam wadah tertutup atau bekukan bila belum sempat diolah.\n"
                "• Potong/haluskan sisa besar agar proses penguraian lebih cepat.\n\n"

                "Manfaat Mengelola Sampah Organik:\n"
                "• Mengurangi volume sampah yang dibuang ke TPA\n"
                "• Menghasilkan pupuk organik berkualitas untuk tanaman\n"
                "• Mengurangi emisi metana dari sampah yang menumpuk\n\n"

                "Langkah praktis mulai sekarang:\n"
                "1) Siapkan 2 wadah: organik & non‑organik.\n"
                "2) Gunakan komposter sederhana atau kotak vermi jika punya ruang kecil.\n"
                "3) Gunakan pupuk kompos untuk tanaman rumah — periksa kandungan dan cara pemakaian.\n\n"
                "Sumber ringkas: praktik pengomposan rumah, panduan lingkungan lokal, dan sumber pertanian organik.",
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
