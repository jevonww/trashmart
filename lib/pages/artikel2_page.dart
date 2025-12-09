import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Artikel2Page extends StatefulWidget {
  const Artikel2Page({super.key});
  @override
  State<Artikel2Page> createState() => _Artikel2PageState();
}

class _Artikel2PageState extends State<Artikel2Page> {
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
              "Kelola Sampah Tingkat Lokal, Bank Sampah RW 01 Boponter Resmi Beroperasi",
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
                "assets/artikel_2.png",
                height: 315,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            // Isi berita
            const Text(
              "berita.depok.go.id – Sebagai langkah konkret dalam pengelolaan sampah di tingkat lokal, "
                  "Kelurahan Bojong Pondok Terong (Boponter), Kecamatan Cipayung, "
                  "meresmikan Bank Sampah RW 01, Rabu (12/11/25).\n\n"

                  "Lurah Boponter, Adi Supriyadi, mengatakan pembentukan bank sampah ini merupakan wujud "
                  "kekompakan warga dalam merespons permasalahan sampah di lingkungan sekitar. "
                  "Kehadirannya juga selaras dengan arahan Pemerintah Kota Depok mengenai pengelolaan sampah di sumbernya.\n\n"

                  "Pembentukan bank sampah ini dimotori oleh kader posyandu serta ibu RW dan RT setempat. Nantinya, "
                  "pengelola bank sampah RW 01 akan menerima sampah nonorganik dan residu, sementara sampah organik "
                  "diangkut ke Unit Pengolahan Sampah (UPS), jelasnya.\n\n"

                  "Ia menambahkan, hasil pengolahan sampah organik yang terproduksi dapat dimanfaatkan "
                  "kembali ke masyarakat untuk dijadikan pupuk tanaman seperti kangkung, bayam, dan sayuran lainnya.\n\n"

                  "Target kami adalah mengurangi jumlah sampah yang masuk ke Tempat Pembuangan Akhir (TPA) "
                  "dengan meningkatkan partisipasi masyarakat dalam memilah sampah dari rumah tangga, ungkapnya.\n\n"

                  "Selain peresmian bank sampah, kegiatan ini juga dirangkaikan dengan panen kangkung di lingkungan sekitar. "
                  "Dengan pelatihan kader, diharapkan program bank sampah dapat berjalan secara mandiri dan konsisten.\n\n"

                  "Sumber: berita.depok.go.id",
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
            color: Color(0xFFF8F3E8), // ← ganti warna di sini
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
        )
    );
  }
}
