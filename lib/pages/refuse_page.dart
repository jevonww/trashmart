import 'package:flutter/material.dart';

class RefusePage extends StatelessWidget {
  const RefusePage({super.key});

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
                            "Refuse",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF445236),
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(
                            "Tolak barang yang\ntidak kamu butuhkan",
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
                    "assets/refuse_header.png",
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
                            "Kenapa Refuse Penting?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "Menolak barang yang tidak diperlukan merupakan langkah pertama yang sangat penting untuk mengurangi sampah.",
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
                      "assets/refuse_earth.png",
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
                    "Tips Refuse",
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
                image: "assets/tas.png",
                title: "Tolak kantong plastik",
                subtitle:
                    "Bawa tas belanja sendiri kemanapun kamu pergi.",
              ),

              const SizedBox(height: 12),

              // ================= CARD 2 =================

              _tipsCard(
                image: "assets/sedotan.png",
                title: "Tolak sedotan sekali pakai",
                subtitle:
                    "Gunakan sedotan stainless atau tanpa sedotan",
              ),

              const SizedBox(height: 12),

              // ================= CARD 3 =================

              _tipsCard(
                image: "assets/kado.png",
                title: "Tolak promo yang tidak perlu",
                subtitle:
                    "Jangan tergoda barang gratis jika kamu tidak membutuhkannya",
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
                            "Setiap kali kamu menolak,\nkamu sudah mencegah\nsampah sebelum tercipta",
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
                      "assets/hand_leaf.png",
                      width: 90,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ================= BENEFIT =================

              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),

                  border: Border.all(
                    color: const Color(0xFFD9D5C9),
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Dampak Positif",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF445236),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceAround,

                      children: [

                        _benefitItem(
                          image: "assets/sampah.png",
                          text: "Sampah berkurang",
                        ),

                        _benefitItem(
                          image: "assets/money.png",
                          text: "Hemat uang",
                        ),

                        _benefitItem(
                          image: "assets/earth.png",
                          text: "Bumi lebih sehat",
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

  // ================= BENEFIT ITEM =================

  Widget _benefitItem({
    required String image,
    required String text,
  }) {
    return Column(
      children: [

        Image.asset(
          image,
          width: 42,
          height: 42,
        ),

        const SizedBox(height: 8),

        SizedBox(
          width: 80,

          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF445236),
            ),
          ),
        ),
      ],
    );
  }
}