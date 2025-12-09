import 'package:flutter/material.dart';

class B3Page extends StatelessWidget {
  const B3Page({super.key});

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
                      "assets/b3.png",
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
                "Sampah B3",
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
              "Sampah B3 adalah jenis sampah yang mengandung bahan kimia berbahaya atau beracun dan dapat menimbulkan risiko bagi kesehatan manusia, hewan, dan lingkungan. Contohnya antara lain baterai bekas, aki, obat-obatan kadaluarsa, cat, oli, pelarut, dan lampu neon yang mengandung merkuri. Sampah B3 memiliki karakteristik beracun, mudah menimbulkan bahaya kebakaran atau ledakan, serta dapat mencemari tanah, air, dan udara jika dibuang sembarangan.\n\n"
              "Contoh Sampah B3:\n"
              "• Baterai & aki kendaraan (mengandung timbal, merkuri)\n"
              "• Lampu neon & tabung fluorescent (merkuri)\n"
              "• Cat & pengencer cat (solven toksik)\n"
              "• Obat-obatan kedaluwarsa & sisa obat\n"
              "• Cairan pembersih & desinfektan pekat\n"
              "• Minyak pelumas bekas (automotive oil)\n"
              "• Pestisida & herbisida rumah tangga\n"
              "• Adhesive (lem) berbahan kimia kuat\n"
              "• Kosmetik berbahan merkuri (whitening creams)\n"
              "• Thermometer air raksa pecah\n\n"

              "Ciri-ciri Sampah B3:\n"
              "• Mengandung zat kimia beracun/berbahaya\n"
              "• Dapat menyebabkan penyakit jika terabsorpsi tubuh\n"
              "• Mencemari tanah & air jika dibuang sembarangan\n"
              "• Memerlukan penanganan khusus & fasilitas tertentu\n\n"

              "Cara Pengelolaan Praktis:\n"
              "1) Identifikasi → Cek label & pastikan termasuk kategori B3.\n"
              "2) JANGAN dicampur → Simpan terpisah dari sampah lain.\n"
              "3) Simpan dengan aman → Wadah tertutup rapat, tempat sejuk/kering, jauh dari anak-anak & hewan.\n"
              "4) Hubungi fasilitas B3 → Cari tahu lokasi TPSS B3 (Tempat Penampungan Sementara Sampah B3) terdekat.\n"
              "5) Serah ke pihak berwenang → Hanya serahkan ke institusi berlisensi untuk menangani B3.\n\n"

              "Tips Penyimpanan B3:\n"
              "• JANGAN dibuang ke saluran air atau tanah.\n"
              "• Simpan di wadah asli (jangan pindah ke wadah lain kecuali terpaksa).\n"
              "• Wadah tertutup rapat, berlabel jelas, jauh dari api.\n"
              "• Jangan campur berbagai jenis B3 (bisa terjadi reaksi kimia).\n"
              "• Saat menangani, gunakan sarung tangan & masker jika perlu.\n\n"

              "Risiko Jika Tidak Dikelola dengan Baik:\n"
              "• Keracunan & penyakit akut/kronis pada manusia\n"
              "• Kontaminasi air minum & sumber air bersih\n"
              "• Merusak ekosistem (tanah, makhluk hidup, vegetasi)\n"
              "• Penumpukan di TPA umum menimbulkan bau & gas beracun\n\n"

              "Langkah praktis mulai sekarang:\n"
              "1) Identifikasi sampah B3 di rumah (baterai, obat kadaluarsa, dll).\n"
              "2) Cari tahu lokasi TPSS B3 atau program pengumpulan B3 di kota Anda.\n"
              "3) Kumpulkan dengan aman di wadah terpisah.\n"
              "4) Antar ke fasilitas resmi (jangan dibuang ke TPA biasa).\n"
              "5) Kurangi pembelian produk berbahan B3 ← gunakan alternatif ramah lingkungan.\n\n"
              "Sumber ringkas: panduan B3 rumah tangga, pedoman KEMENLINGKUNGAN RI, & program TPSS B3 lokal.",
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
