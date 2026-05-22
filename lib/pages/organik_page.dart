import 'package:flutter/material.dart';
import 'trash_category_detail_page.dart';

class OrganikPage extends StatelessWidget {
  const OrganikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TrashCategoryDetailPage(
      title: "Organik",
      image: "assets/organik.png",

      description:
          "Sampah organik adalah sampah yang berasal dari makhluk hidup (hewan, tumbuhan, dan manusia) yang dapat terurai secara alami melalui proses biologis.",

      examples: [
        {"title": "Sisa Makanan", "image": "assets/sampahorganik.png"},
        {"title": "Kayu", "image": "assets/kayu.png"},
        {"title": "Daun Kering", "image": "assets/daun_kering.png"},
        {"title": "Kantong Teh", "image": "assets/kantong_teh.png"},
      ],

      characteristics: [
        "Mudah membusuk",
        "Memiliki kadar air tinggi",
        "Menghasilkan bau",
        "Mudah terurai alami",
      ],

      processing: [
        {"title": "Kompos", "subtitle": "Diolah menjadi pupuk alami."},
        {"title": "Biopori", "subtitle": "Membantu resapan air."},
      ],
    );
  }
}
