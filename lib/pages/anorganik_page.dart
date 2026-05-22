import 'package:flutter/material.dart';
import 'trash_category_detail_page.dart';

class AnorganikPage extends StatelessWidget {
  const AnorganikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TrashCategoryDetailPage(
      title: "Anorganik",
      image: "assets/anorganik.png",

      description:
          "Sampah anorganik adalah sampah yang diproduksi dari bahan-bahan non-hayati, tidak dapat diproses secara alami, sumber daya alam yang tidak terbarui, dan juga hasil proses teknologi pengelolaan bahan tambang serta industri.",

      examples: [
        {"title": "Botol plastik", "image": "assets/botol_plastik.png"},
        {"title": "Kaleng minuman", "image": "assets/kaleng.png"},
        {"title": "Kaca", "image": "assets/kaca.png"},
        {"title": "Plastik", "image": "assets/plastik.png"},
      ],

      characteristics: [
        "Sulit terurai",
        "Dapat didaur ulang",
        "Berasal dari bahan sintetis",
        "Tahan lama",
      ],

      processing: [
        {
          "title": "Reduce",
          "subtitle": "Mengurangi penggunaan barang sekali pakai.",
        },
        {
          "title": "Reuse",
          "subtitle": "Digunakan kembali untuk kebutuhan lain.",
        },
        {"title": "Recycle", 
        "subtitle": "Diolah kembali menjadi produk baru."
        },
      ],
    );
  }
}
