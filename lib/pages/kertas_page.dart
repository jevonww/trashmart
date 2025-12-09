import 'package:flutter/material.dart';

class KertasPage extends StatelessWidget {
  const KertasPage({super.key});

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
                      "assets/kertas.png",
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
                "Sampah Kertas",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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
              "Sampah kertas adalah limbah yang berasal dari bahan kertas, kardus, koran, dan bahan cellulose lainnya. Kertas dapat didaur ulang dan relatif mudah dikelola.\n\n"

              "Contoh Sampah Kertas:\n"
              "• Kertas bekas tulis/kantor\n"
              "• Kardus & kotak pembungkus\n"
              "• Koran & majalah lama\n"
              "• Tas kertas\n"
              "• Serbet & tisu bekas\n"
              "• Kemasan karton\n\n"

              "Ciri-ciri:\n"
              "• Mudah diuraikan (bisa membusuk)\n"
              "• Dapat didaur ulang berkali-kali\n"
              "• Tidak beracun jika basah atau membusuk\n"
              "• Ringan & mudah dikumpulkan\n\n"

              "Cara Pengelolaan Praktis:\n"
              "1) Kumpulkan kertas bekas → Pisahkan kardus dari kertas biasa.\n"
              "2) Keringkan → Pastikan tidak basah atau terkena minyak/noda berat.\n"
              "3) Ikat/tekan → Kompres untuk menghemat ruang sebelum diserahkan.\n"
              "4) Kirim ke pengepul/bank sampah → Dapatkan uang atau poin reward.\n\n"

              "Tips Pemilahan & Penyimpanan:\n"
              "• Pisahkan kardus tebal dari kertas tipis (nilai harga berbeda).\n"
              "• Hindari kertas yang berminyak/terkena minyak makanan.\n"
              "• Jangan campur dengan plastik atau karet.\n"
              "• Simpan di tempat kering agar tidak rusak/berubah bentuk.\n\n"

              "Manfaat Mengelola Sampah Kertas:\n"
              "• Mengurangi penggunaan pohon baru (hemat hutan)\n"
              "• Menghemat air & energi dalam proses produksi kertas baru\n"
              "• Dapatkan penghasilan dari penjualan kertas bekas\n"
              "• Mengurangi sampah di TPA\n\n"

              "Langkah praktis mulai sekarang:\n"
              "1) Siapkan wadah/box khusus untuk kumpulan kertas.\n"
              "2) Mulai dari kantor/rumah: koran, kardus, kertas bekas.\n"
              "3) Kumpu secara berkala (2-4 minggu).\n"
              "4) Hubungi pengepul atau bawa ke bank sampah.\n"
              "5) Gunakan kertas daur ulang untuk produk rumah tangga.\n\n"
              "Sumber ringkas: panduan daur ulang kertas, program bank sampah komunitas, dan tips pengelolaan sampah perkotaan.",
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
