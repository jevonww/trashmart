import 'package:flutter/material.dart';
import 'trash_category_detail_page.dart';

class B3Page extends StatelessWidget {
  const B3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const TrashCategoryDetailPage(
      title: "Sampah B3",
      image: "assets/b3.png",

      description:
          "Sampah B3 adalah singkatan dari sampah Bahan Berbahaya dan Beracun, yaitu sisa-sisa dari suatu proses yang mengandung zat yang dapat mencemari dan merusak lingkungan, serta berbahaya bagi kesehatan manusia dan makhluk hidup lainnya.",

      examples: [
        {"title": "Baterai bekas", "image": "assets/baterai.png"},
        {"title": "Aki Kendaraan", "image": "assets/aki.png"},
        {"title": "Obat kadaluarsa", "image": "assets/obat.png"},
        {"title": "Deterjen", "image": "assets/deterjen.png"},
      ],

      characteristics: [
        "Mengandung zat beracun",
        "Berbahaya bagi kesehatan",
        "Tidak boleh dibuang sembarangan",
        "Perlu penanganan khusus",
      ],

      processing: [
        {
          "title": "Pengolahan Khusus",
          "subtitle": "Ditangani oleh fasilitas khusus.",
        },
        {
          "title": "Pemisahan Aman",
          "subtitle": "Dipisahkan dari sampah biasa.",
        },
      ],
    );
  }
}
