import 'package:flutter/material.dart';
import 'artikel1_page.dart';
import 'artikel2_page.dart';
import 'artikel3_page.dart';

class TrashNewsPage extends StatelessWidget {
  final ValueChanged<int>? onChangeTab;

  const TrashNewsPage({super.key, this.onChangeTab});

  @override
  Widget build(BuildContext context) {
    final List<_NewsData> newsList = [
      const _NewsData(
        title:
            "Pertemuan bilateral Indonesia - Norwegia bahas solusi sampah plastik",
        imageUrl: "assets/artikel_1.png",
        page: Artikel1Page(),
        category: "Lingkungan",
      ),
      const _NewsData(
        title:
            "Kelola Sampah Tingkat Lokal, Bank Sampah RW 01 Depok Resmi Beroperasi",
        imageUrl: "assets/artikel_2.png",
        page: Artikel2Page(),
        category: "Bank Sampah",
      ),
      const _NewsData(
        title: "Pengelolaan Sampah Meningkat di 2025",
        imageUrl: "assets/artikel_3.png",
        page: Artikel3Page(),
        category: "Edukasi",
      ),
    ];

    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 80),
        children: [
          // ================= HEADER =================
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (onChangeTab != null) {
                    onChangeTab!(0);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: Color(0xFF3F4F44),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TrashNews",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF26351F),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Update info terbaru seputar lingkungan",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // ================= HERO CARD =================
          _featuredNewsCard(context, newsList.first),

          const SizedBox(height: 26),

          // ================= SECTION TITLE =================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Berita Terbaru",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF26351F),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF3F4F44).withOpacity(0.10),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Text(
                  "3 Artikel",
                  style: TextStyle(
                    color: Color(0xFF3F4F44),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ================= NEWS LIST =================
          for (final news in newsList) _newsItem(context, news),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // ================= FEATURED CARD =================

  Widget _featuredNewsCard(BuildContext context, _NewsData news) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => news.page),
        );
      },
      child: Container(
        height: 230,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3F4F44).withOpacity(0.24),
              blurRadius: 22,
              spreadRadius: 1,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned.fill(
                child: _buildImage(
                  news.imageUrl,
                  height: 230,
                  width: double.infinity,
                ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.72),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 14,
                left: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.eco_rounded,
                        color: Color(0xFF3F4F44),
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        news.category,
                        style: const TextStyle(
                          color: Color(0xFF3F4F44),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 18,
                right: 18,
                bottom: 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Artikel Pilihan",
                      style: TextStyle(
                        color: Color(0xFFFFD166),
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Text(
                      news.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        height: 1.25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Text(
                          "Lihat selengkapnya",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const Spacer(),

                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.20),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= NEWS ITEM =================

  Widget _newsItem(BuildContext context, _NewsData news) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => news.page),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.075),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.85),
              blurRadius: 4,
              offset: const Offset(-2, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _buildImage(
                news.imageUrl,
                width: 104,
                height: 104,
              ),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3F4F44).withOpacity(0.10),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      news.category,
                      style: const TextStyle(
                        color: Color(0xFF3F4F44),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  const SizedBox(height: 9),

                  Text(
                    news.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF26351F),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Text(
                        "Lihat selengkapnya",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 15,
                        color: Colors.green[700],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= IMAGE BUILDER =================

  Widget _buildImage(
    String imageUrl, {
    required double height,
    required double width,
  }) {
    final bool isNetwork = imageUrl.trim().toLowerCase().startsWith('http');

    if (isNetwork) {
      return Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        errorBuilder: (context, error, stackTrace) {
          return _imageErrorBox(height: height, width: width);
        },
      );
    }

    return Image.asset(
      imageUrl,
      height: height,
      width: width,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return _imageErrorBox(height: height, width: width);
      },
    );
  }

  Widget _imageErrorBox({
    required double height,
    required double width,
  }) {
    return Container(
      height: height,
      width: width,
      color: const Color(0xFFECE7DA),
      child: const Center(
        child: Icon(
          Icons.image_not_supported_rounded,
          color: Color(0xFF3F4F44),
        ),
      ),
    );
  }
}

// ================= MODEL =================

class _NewsData {
  final String title;
  final String imageUrl;
  final Widget page;
  final String category;

  const _NewsData({
    required this.title,
    required this.imageUrl,
    required this.page,
    required this.category,
  });
}