import 'package:flutter/material.dart';

class ReusePage extends StatelessWidget {
  const ReusePage({super.key});

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
                            "Reuse",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF445236),
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(
                            "Gunakan kembali barang\nyang masih layak pakai",
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
                    "assets/reuse_header.png",
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
                          "Ide & Inspirasi Reuse",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF445236),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ================= GRID =================

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.68,
                      physics:
                          const NeverScrollableScrollPhysics(),

                      children: [

                        _reuseCard(
                          image: "assets/reuse1.png",
                          title:
                              "Kaleng Bekas jadi Tempat Pensil",
                          subtitle:
                              "Bersihkan kaleng, hias sesuai selera, dan gunakan untuk menyimpan alat tulis.",
                        ),

                        _reuseCard(
                          image: "assets/reuse2.png",
                          title:
                              "Botol Kaca jadi Lampu Dekorasi",
                          subtitle:
                              "Isi botol dengan lampu LED kecil untuk hiasan kamar yang estetik.",
                        ),

                        _reuseCard(
                          image: "assets/reuse3.png",
                          title:
                              "Kaos Lama jadi Lap Pembersih",
                          subtitle:
                              "Potong kaos yang sudah tidak terpakai menjadi kain lap serbaguna.",
                        ),

                        _reuseCard(
                          image: "assets/reuse4.png",
                          title:
                              "Kaleng Bekas jadi Pot Tanaman",
                          subtitle:
                              "Buat lubang drainase, cat dan hiasi kaleng, kemudian tanami tanaman kecil.",
                        ),

                        _reuseCard(
                          image: "assets/reuse5.png",
                          title:
                              "Celana Jeans jadi Organizer Dinding",
                          subtitle:
                              "Potong & pasang saku jeans pada tali di gantungan, jadikan tempat penyimpanan kecil.",
                        ),

                        _reuseCard(
                          image: "assets/reuse6.png",
                          title:
                              "Kardus Bekas jadi Tempat Penyimpanan",
                          subtitle:
                              "Hias kardus bekas dan gunakan untuk menyimpan barang.",
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ================= REMINDER =================

              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xFF445236),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Row(
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [

                              const Icon(
                                Icons.lightbulb_outline,
                                color: Colors.white,
                                size: 20,
                              ),

                              const SizedBox(width: 8),

                              const Text(
                                "Ingat!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "Kreativitas kecil bisa membuat\nbarang lama jadi bermanfaat\nkembali.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Image.asset(
                      "assets/reuse_leaf.png",
                      width: 90,
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

  // ================= REUSE CARD =================

  Widget _reuseCard({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F3E8),
        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: const Color(0xFFD9D5C9),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(14),
            ),

            child: Image.asset(
              image,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),

          // TEXT
          Padding(
            padding: const EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF445236),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}