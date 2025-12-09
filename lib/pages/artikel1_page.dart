import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Artikel1Page extends StatefulWidget {
  const Artikel1Page({super.key});
  @override
  State<Artikel1Page> createState() => _Artikel1PageState();
}

class _Artikel1PageState extends State<Artikel1Page> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F3E8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Judul
            const Text(
              "Pertemuan bilateral Indonesia - Norwegia bahas solusi sampah plastik ",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),

            // Info tanggal
            Row(
              children: const [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 6),
                Text("13 Nov 2025 08:19 WIB",
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
                SizedBox(width: 16),
               
              ],
            ),
            const SizedBox(height: 16),

            // Gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/artikel_1.png",
                height: 315,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            // Isi berita
            const Text(
              "Belém (ANTARA) - Menteri Lingkungan Hidup Hanif Faisol Nurofiq melakukan pertemuan bilateral "
                  "dengan Menteri Iklim dan Lingkungan Hidup Norwegia, Andreas Bjelland Eriksen, untuk membahas "
                  "penanganan sampah plastik.\n\n"

                  "\"Membahas kesiapan Indonesia untuk menjadi lead di dalam langkah penanganan polusi plastik,\" kata "
                  "Menteri Hanif Faisol Nurofiq di sela-sela pelaksanaan Konferensi Perubahan Iklim PBB ke-30 (COP30) "
                  "di Belém, Brasil, Rabu (12/11) waktu setempat.\n\n"

                  "Menurut dia, pemerintah Indonesia sangat berkomitmen untuk mengatasi permasalahan sampah plastik "
                  "di Tanah Air. \"Indonesia sangat kuat tekad untuk kemudian mengurangi secara bertahap polusi plastik "
                  "di Tanah Air. Kita negara besar tentu memiliki timbulan sampah yang cukup besar,\" katanya.\n\n"

                  "Pihaknya mencatat Indonesia menghasilkan 143 ribu ton sampah per hari. Dari jumlah tersebut, sekitar "
                  "12 hingga 17 persennya merupakan sampah plastik. \"Dari 143 ribu ton (sampah) per hari, 12 - 17 persennya "
                  "merupakan sampah plastik yang sudah sekian tahun belum bisa kita tangani dengan serius,\" katanya.\n\n"

                  "Hanif Faisol Nurofiq pun menekankan penanganan permasalahan sampah plastik harus melibatkan banyak pihak "
                  "sehingga penanganannya bisa dilakukan secara masif, terukur, dan sistematis. \"Sehingga apa yang diminta oleh "
                  "Bapak Presiden melalui Peraturan Presiden Nomor 12 Tahun 2025 tentang Rencana Pembangunan Jangka Menengah "
                  "Nasional (RPJMN), Indonesia akan mampu menyelesaikan penanganan sampah selesai 100 persen di tahun 2029,\" "
                  "katanya.\n\n"

                  "Selain melakukan pertemuan bilateral dengan Pemerintah Norwegia, Menteri Lingkungan Hidup Hanif Faisol "
                  "Nurofiq juga melakukan pertemuan bilateral dengan Menteri Lingkungan Hidup, Pembangunan Berkelanjutan "
                  "Republik Kongo, Arlette Soudan-Nonaul untuk memulihkan lahan gambut.\n\n",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom action bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: Color(0xFFF8F3E8),
          border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Komentar
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBDD4C0),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              icon: const Icon(Iconsax.message),
              label: const Text("Tambahkan komentar..."),
            ),

            const SizedBox(width: 8),

            Row(
              children: [
                IconButton(
                  onPressed: () => setState(() => _isLiked = !_isLiked),
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    size: 28,
                    color: _isLiked ? Colors.red : Colors.black,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.bookmark_border, size: 28),
                const SizedBox(width: 16),
                const Icon(Icons.share, size: 28),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
