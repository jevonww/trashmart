import 'package:flutter/material.dart';

class RecyclePage extends StatelessWidget {
  const RecyclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3E8),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ================= HEADER =================

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // BACK BUTTON
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: Container(
                      width: 38,
                      height: 38,

                      decoration: const BoxDecoration(
                        color: Color(0xFF445236),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // TEXT
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Recycle",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF445236),
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(
                            "Daur ulang sampah menjadi\nbarang baru yang bermanfaat",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // IMAGE
                  Image.asset(
                    "assets/recycle_header.png",
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ================= CONTENT BOX =================

              Container(
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),

                  border: Border.all(
                    color: const Color(0xFFB8C49A),
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ================= TITLE =================

                    Row(
                      children: [

                        Image.asset(
                          "assets/leaf.png",
                          width: 22,
                          height: 22,
                        ),

                        const SizedBox(width: 8),

                        const Text(
                          "Ide & Inspirasi Recycle",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF445236),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ================= CARD 1 =================

                    _recycleCard(
                      number: "1",
                      image: "assets/recycle1.png",
                      title: "Frame Foto dari Kertas Bekas",

                      steps: [
                        "Siapkan kertas bekas, lem, dan karton.",
                        "Gulung potongan kertas kecil.",
                        "Tempel gulungan hingga membentuk frame.",
                        "Pasang foto di tengahnya.",
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ================= CARD 2 =================

                    _recycleCard(
                      number: "2",
                      image: "assets/recycle2.png",
                      title: "Gantungan Kunci dari Tutup Botol",

                      steps: [
                        "Siapkan tutup botol dan gantungan kecil.",
                        "Lubangi tutup botol.",
                        "Hias sesuai keinginan.",
                        "Pasang gantungan kunci.",
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ================= CARD 3 =================

                    _recycleCard(
                      number: "3",
                      image: "assets/recycle3.png",
                      title: "Celengan dari Botol Bekas",

                      steps: [
                        "Siapkan botol bekas dan cutter.",
                        "Buat lubang kecil untuk memasukkan uang.",
                        "Hias botol sesuai keinginan.",
                        "Celengan siap diisi uang.",
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ================= CARD 4 =================

                    _recycleCard(
                      number: "4",
                      image: "assets/recycle4.png",
                      title: "Sampah Organik jadi Kompos",

                      steps: [
                        "Kumpulkan sisa makanan atau daun.",
                        "Masukkan ke komposter.",
                        "Aduk secara berkala.",
                        "Kompos siap digunakan.",
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ================= BENEFIT =================

              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xFF445236),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Manfaat Recycle",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                      children: [

                        _benefitItem(
                          icon: Icons.energy_savings_leaf,
                          text: "Menghemat\nsumber daya",
                        ),

                        _benefitItem(
                          icon: Icons.public,
                          text: "Mengurangi\npencemaran",
                        ),

                        _benefitItem(
                          icon: Icons.recycling,
                          text: "Menciptakan\nproduk baru",
                        ),

                        _benefitItem(
                          icon: Icons.eco,
                          text: "Bumi lebih\nberkelanjutan",
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ================= RECYCLE CARD =================

  Widget _recycleCard({
    required String number,
    required String image,
    required String title,
    required List<String> steps,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: const Color(0xFFF7F3E8),
        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: const Color(0xFFD9D5C9),
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),

            child: Image.asset(
              image,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                // NUMBER + TITLE
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Container(
                      width: 24,
                      height: 24,

                      decoration: const BoxDecoration(
                        color: Color(0xFF445236),
                        shape: BoxShape.circle,
                      ),

                      child: Center(
                        child: Text(
                          number,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF445236),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // STEPS
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: List.generate(
                    steps.length,
                    (index) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: 2),

                      child: Text(
                        "${index + 1}. ${steps[index]}",
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= BENEFIT ITEM =================

  Widget _benefitItem({
    required IconData icon,
    required String text,
  }) {
    return Column(
      children: [

        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),

        const SizedBox(height: 8),

        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}