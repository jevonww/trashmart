import 'package:flutter/material.dart';
import 'trash_category_detail_page.dart';

class ResiduPage extends StatelessWidget {
  const ResiduPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TrashCategoryDetailPage(
      title: "Residu",
      image: "assets/residu.png",

      description:
          "Sampah residu adalah sampah yang sulit didaur ulang karena alasan keterbatasan teknologi, biaya, sumber daya alam, maupun sumber daya manusia.",

      examples: [
        {"title": "Styrofoam", "image": "assets/styrofoam.png"},
        {"title": "Popok Bekas", "image": "assets/popok.png"},
        {"title": "Puntung rokok", "image": "assets/rokok.png"},
        {"title": "Masker bekas", "image": "assets/masker.png"},
      ],

      characteristics: [
        "Sulit didaur ulang",
        "Mengandung kotoran",
        "Tidak bernilai guna",
        "Harus dibuang dengan benar",
      ],

      processing: [
        {"title": "Pembuangan Akhir", "subtitle": "Dibuang ke tempat khusus."},
        {
          "title": "Pengurangan Sampah",
          "subtitle": "Mengurangi penggunaan barang sekali pakai.",
        },
      ],
    );
  }
}
