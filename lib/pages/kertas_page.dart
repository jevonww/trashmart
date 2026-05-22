import 'package:flutter/material.dart';
import 'trash_category_detail_page.dart';

class KertasPage extends StatelessWidget {
  const KertasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TrashCategoryDetailPage(
      title: "Kertas",
      image: "assets/kertas.png",

      description:
          "Sampah kertas adalah limbah dari produk kertas tidak terpakai (koran, kardus, dokumen, majalah, kemasan) yang umum ditemukan dan dapat terurai, namun jumlahnya besar bisa menimbulkan masalah lingkungan seperti emisi gas metana, polusi TPA, dan membutuhkan banyak lahan",

      examples: [
        {"title": "Koran bekas", "image": "assets/koran.png"},
        {"title": "Kardus", "image": "assets/kardus.png"},
        {"title": "Kantong Kertas", "image": "assets/kantong_kertas.png"},
        {"title": "Kertas HVS", "image": "assets/kertas_hvs.png"},
      ],

      characteristics: [
        "Mudah didaur ulang",
        "Ringan",
        "Mudah terbakar",
        "Dapat digunakan kembali",
      ],

      processing: [
        {
          "title": "Reduce",
          "subtitle":
              "Gunakan kertas dua sisi saat mencetak dan beralih ke media digital.",
        },
        {
          "title": "Reuse",
          "subtitle":
              "Gunakan koran bekas untuk membungkus barang atau sebagai alas.",
        },
        {
          "title": "Recycle",
          "subtitle": "Dimanfaatkan menjadi produk kreatif.",
        },
      ],
    );
  }
}
