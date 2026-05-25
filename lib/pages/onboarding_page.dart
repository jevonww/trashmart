import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final Color darkGreen = const Color(0xFF3C5122);
  final Color softGreen = const Color(0xFFD1E2C4);
  final Color cream = const Color(0xFFF8F3E8);
  final Color yellow = const Color(0xFFFFD166);

  final List<Map<String, String>> pages = [
    {
      'title': 'Kenali Sampah,\nMulai dari Dirimu',
      'desc':
          'Semua dimulai dari pengetahuan kecil yang membawa perubahan besar untuk lingkungan.',
      'image': 'assets/onboard1.png',
    },
    {
      'title': 'Belajar Seru\nTentang Sampah',
      'desc':
          'Temukan materi, artikel, dan tips menarik agar kamu makin peduli dengan sampah.',
      'image': 'assets/onboard2.png',
    },
    {
      'title': 'Mulai Kebiasaan\nBaik Hari Ini!',
      'desc':
          'Bangun kebiasaan positif, kumpulkan poin, dan jadilah bagian dari Smartizen.',
      'image': 'assets/onboard3.png',
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void next() {
    if (currentIndex < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    } else {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  void back() {
    if (currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void skip() {
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = currentIndex == pages.length - 1;

    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -80,
              child: _decorCircle(
                size: 190,
                color: softGreen.withOpacity(0.85),
              ),
            ),

            Positioned(
              top: 130,
              left: -65,
              child: _decorCircle(
                size: 145,
                color: yellow.withOpacity(0.28),
              ),
            ),

            Positioned(
              bottom: -95,
              left: -80,
              child: _decorCircle(
                size: 210,
                color: darkGreen.withOpacity(0.10),
              ),
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 14, 22, 0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/logo_tanpanama.png",
                            width: 34,
                            height: 34,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "TrashSmart",
                            style: TextStyle(
                              color: darkGreen,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      if (!isLastPage)
                        GestureDetector(
                          onTap: skip,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Text(
                              "Lewati",
                              style: TextStyle(
                                color: darkGreen,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: pages.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          double pageValue = 0;

                          if (_controller.position.haveDimensions) {
                            pageValue = (_controller.page ?? 0) - index;
                          } else {
                            pageValue = currentIndex.toDouble() - index;
                          }

                          final double opacity =
                              (1 - pageValue.abs()).clamp(0.0, 1.0);
                          final double translateY = pageValue.abs() * 35;
                          final double scale =
                              (1 - pageValue.abs() * 0.06).clamp(0.90, 1.0);

                          return Opacity(
                            opacity: opacity == 0 ? 1 : opacity,
                            child: Transform.translate(
                              offset: Offset(0, translateY),
                              child: Transform.scale(
                                scale: scale,
                                child: _onboardingContent(index),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
                  child: Column(
                    children: [
                      _indicator(),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          if (currentIndex != 0)
                            Expanded(
                              child: SizedBox(
                                height: 54,
                                child: OutlinedButton(
                                  onPressed: back,
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: darkGreen,
                                      width: 1.2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  child: Text(
                                    "Kembali",
                                    style: TextStyle(
                                      color: darkGreen,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else
                            const Expanded(child: SizedBox()),

                          const SizedBox(width: 14),

                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 54,
                              child: ElevatedButton(
                                onPressed: next,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: darkGreen,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      isLastPage ? "Mulai Sekarang" : "Lanjut",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _onboardingContent(int index) {
    final data = pages[index];

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.78),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.white.withOpacity(0.9),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 22,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: 295,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: softGreen.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 18,
                        left: 20,
                        child: _miniBubble(
                          icon: Icons.eco_rounded,
                          color: const Color(0xFF8CB66B),
                        ),
                      ),

                      Positioned(
                        right: 22,
                        top: 28,
                        child: _miniBubble(
                          icon: Icons.recycling_rounded,
                          color: yellow,
                        ),
                      ),

                      Positioned(
                        left: 28,
                        bottom: 28,
                        child: _miniBubble(
                          icon: Icons.delete_outline_rounded,
                          color: const Color(0xFF4CB6AE),
                        ),
                      ),

                      Center(
                        child: Image.asset(
                          data['image']!,
                          height: 245,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                Text(
                  data['title']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                    color: darkGreen,
                    height: 1.12,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  data['desc']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: darkGreen.withOpacity(0.76),
                    fontWeight: FontWeight.w600,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages.length,
        (index) {
          final bool active = currentIndex == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: active ? 28 : 9,
            height: 9,
            decoration: BoxDecoration(
              color: active ? darkGreen : darkGreen.withOpacity(0.23),
              borderRadius: BorderRadius.circular(100),
            ),
          );
        },
      ),
    );
  }

  Widget _decorCircle({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _miniBubble({
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: darkGreen,
        size: 23,
      ),
    );
  }
}