import 'package:flutter/material.dart';

class ReducePage extends StatelessWidget {
  const ReducePage({super.key});

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
                            "Reduce",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF445236),
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(
                            "Kurangi penggunaan barang\nyang menghasilkan sampah",
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
                    "assets/reduce_header.png",
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ================= WHY CARD =================

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Kenapa Reduce Penting?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "Mengurangi penggunaan berarti menghemat sumber daya dan mengurangi jumlah sampah.",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    Image.asset(
                      "assets/reduce_bln.png",
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

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
                    "Tips Reduce",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF445236),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ================= CARD 1 =================

              _tipsCard(
                image: "assets/basket.png",
                title: "Beli seperlunya",
                subtitle:
                    "Belilah barang sesuai kebutuhan, jangan berlebihan.",
              ),

              const SizedBox(height: 12),

              // ================= CARD 2 =================

              _tipsCard(
                image: "assets/jar.png",
                title: "Pilih produk minim kemasan",
                subtitle:
                    "Hindari produk yang dibungkus plastik secara berlebihan dan pilih kemasan isi ulang.",
              ),

              const SizedBox(height: 12),

              // ================= CARD 3 =================

              _tipsCard(
                image: "assets/food.png",
                title: "Menghabiskan makanan",
                subtitle:
                    "Mengambil porsi makan secukupnya agar tidak tersisa menjadi sampah makanan.",
              ),

              const SizedBox(height: 12),

              // ================= CARD 4 =================

              _tipsCard(
                image: "assets/cutlery.png",
                title: "Kurangi barang sekali pakai",
                subtitle:
                    "Pilih alat makan, botol minum, dan perlengkapan yang bisa digunakan berulang kali.",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [

                              const Icon(
                                Icons.wb_sunny_outlined,
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
                            "Kebiasaan kecil hari ini,\nberdampak besar untuk masa\ndepan bumi.",
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
                      "assets/refuse_earth.png",
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

  // ================= TIPS CARD =================

  Widget _tipsCard({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: const Color(0xFFF7F3E8),
        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: const Color(0xFFD9D5C9),
        ),
      ),

      child: Row(
        children: [

          Image.asset(
            image,
            width: 60,
            height: 60,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF445236),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
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