import 'package:flutter/material.dart';

class TrashCategoryDetailPage extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final List<Map<String, String>> examples;
  final List<String> characteristics;
  final List<Map<String, String>> processing;

  const TrashCategoryDetailPage({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    required this.examples,
    required this.characteristics,
    required this.processing,
  });

  static const darkOlive = Color(0xFF3F4F28);
  static const softGreen = Color(0xFF8DB36F);
  static const cream = Color(0xFFF4F1E8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Container(
                height: 340,
                width: double.infinity,

                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4E6A38), Color(0xFF2F3E1F)],
                  ),

                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),

                child: Stack(
                  children: [
                    Positioned(
                      top: -40,
                      right: -20,

                      child: Container(
                        height: 180,
                        width: 180,

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: -50,
                      left: -30,

                      child: Container(
                        height: 160,
                        width: 160,

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    Positioned(
                      top: 55,
                      right: 35,

                      child: Icon(
                        Icons.eco,
                        color: Colors.white.withOpacity(0.15),
                        size: 55,
                      ),
                    ),

                    Positioned(
                      bottom: 90,
                      left: 25,

                      child: Icon(
                        Icons.spa,
                        color: Colors.white.withOpacity(0.12),
                        size: 75,
                      ),
                    ),

                    // BUTTON BACK
                    Positioned(
                      top: 20,
                      left: 20,

                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),

                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // CONTENT
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            padding: const EdgeInsets.all(22),

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.15),
                                width: 1.5,
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),

                            child: Image.asset(image, fit: BoxFit.contain),
                          ),

                          const SizedBox(height: 24),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),

                            child: Text(
                              title,
                              textAlign: TextAlign.center,

                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),

                            child: Text(
                              description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: darkOlive,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.orange.shade400,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          "Kategori Sampah",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // PENGERTIAN
                    _sectionCard(
                      title: "Pengertian",
                      icon: Icons.menu_book_rounded,

                      child: Text(
                        description,
                        style: const TextStyle(height: 1.7, fontSize: 15),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // CONTOH
                    _sectionCard(
                      title: "Contoh",
                      icon: Icons.eco_rounded,

                      child: Column(
                        children: examples.map((e) => _exampleItem(e)).toList(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // CIRI-CIRI
                    _sectionCard(
                      title: "Ciri-ciri",
                      icon: Icons.check_circle_outline,

                      child: Column(
                        children: characteristics
                            .map((e) => _bullet(e))
                            .toList(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // PENGOLAHAN
                    _sectionCard(
                      title: "Cara Pengolahan",
                      icon: Icons.recycling,

                      child: Column(
                        children: processing
                            .map(
                              (e) => _processItem(e["title"]!, e["subtitle"]!),
                            )
                            .toList(),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: softGreen),

              const SizedBox(width: 10),

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: darkOlive,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          child,
        ],
      ),
    );
  }

  // EXAMPLE ITEM
  Widget _exampleItem(Map<String, String> item) {
    String text = item["title"] ?? "";
    String imagePath = item["image"] ?? image;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Container(
        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: cream,
          borderRadius: BorderRadius.circular(18),
        ),

        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(
                color: softGreen.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),

              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _processItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: cream,
          borderRadius: BorderRadius.circular(18),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(
                color: softGreen.withOpacity(0.2),
                shape: BoxShape.circle,
              ),

              child: const Icon(Icons.recycling, color: darkOlive),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey.shade700, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),

          Expanded(child: Text(text, style: const TextStyle(height: 1.6))),
        ],
      ),
    );
  }
}
