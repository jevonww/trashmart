import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Artikel3Page extends StatefulWidget {
  const Artikel3Page({super.key});

  @override
  State<Artikel3Page> createState() => _Artikel3PageState();
}

class _Artikel3PageState extends State<Artikel3Page> {
  bool _isLiked = false;
  bool isSaved = false;
  bool isRewardClaimed = false;
  bool _dialogShowing = false;

  final supabase = Supabase.instance.client;
  final ScrollController _scrollController = ScrollController();

  static const int rewardPoint = 20;

  Future<void> claimArticleReward() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      final existing = await supabase
          .from('article_rewards')
          .select()
          .eq('user_id', user.id)
          .eq('article_id', 'artikel_3');

      if (existing.isNotEmpty) return;

      final profile = await supabase
          .from('profiles')
          .select('points')
          .eq('id', user.id)
          .maybeSingle();

      if (profile == null) {
        await supabase.from('profiles').insert({
          'id': user.id,
          'points': 0,
        });
      }

      final updatedProfile = await supabase
          .from('profiles')
          .select('points')
          .eq('id', user.id)
          .single();

      final int currentPoint = updatedProfile['points'] ?? 0;

      await supabase
          .from('profiles')
          .update({'points': currentPoint + rewardPoint}).eq('id', user.id);

      await supabase.from('article_rewards').insert({
        'user_id': user.id,
        'article_id': 'artikel_3',
      });
    } catch (e) {
      debugPrint("ERROR CLAIM REWARD: $e");
    }
  }

  Future<void> showClaimDialog() async {
    if (_dialogShowing) return;

    setState(() {
      _dialogShowing = true;
    });

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFFF8F3E8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.card_giftcard,
                    color: Color(0xFF3E472D),
                    size: 60,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Klaim Poinmu!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Kamu mendapatkan\n$rewardPoint poin",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text("Batal"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);

                          await claimArticleReward();

                          final user = supabase.auth.currentUser;
                          if (user == null) return;

                          final profile = await supabase
                              .from('profiles')
                              .select('points')
                              .eq('id', user.id)
                              .single();

                          final int totalPoint = profile['points'] ?? 0;

                          if (!mounted) return;
                          showSuccessDialog(totalPoint);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3E472D),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Klaim",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (mounted) {
      setState(() {
        _dialogShowing = false;
      });
    }
  }

  void showSuccessDialog(int totalPoint) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFFF8F3E8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Color(0xFF3E472D),
                    size: 60,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Yeay! Berhasil",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "+$rewardPoint poin berhasil ditambahkan",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "Total poin kamu sekarang\n$totalPoint poin",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3E472D),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Lanjut",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> checkRewardStatus() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final existing = await supabase
        .from('article_rewards')
        .select()
        .eq('user_id', user.id)
        .eq('article_id', 'artikel_3');

    if (mounted) {
      setState(() {
        isRewardClaimed = existing.isNotEmpty;
      });
    }
  }

  Future<void> checkSavedStatus() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final existing = await supabase
        .from('saved_articles')
        .select()
        .eq('user_id', user.id)
        .eq('article_id', 'artikel_3');

    if (mounted) {
      setState(() {
        isSaved = existing.isNotEmpty;
      });
    }
  }

  Future<void> toggleSaveArticle() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    if (isSaved) {
      await supabase
          .from('saved_articles')
          .delete()
          .eq('user_id', user.id)
          .eq('article_id', 'artikel_3');

      if (!mounted) return;

      setState(() {
        isSaved = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Artikel dihapus dari simpan")),
      );
    } else {
      await supabase.from('saved_articles').insert({
        'user_id': user.id,
        'article_id': 'artikel_3',
        'title':
            'Pemkot Bandung membangun empat insinerator baru atasi masalah sampah',
        'image': 'assets/artikel_3.png',
      });

      if (!mounted) return;

      setState(() {
        isSaved = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Artikel berhasil disimpan")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    initReward();
  }

  Future<void> initReward() async {
    await checkRewardStatus();
    await checkSavedStatus();

    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;

      if (!isRewardClaimed &&
          !_dialogShowing &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 50) {
        setState(() {
          isRewardClaimed = true;
        });

        showClaimDialog();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F3E8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.fromLTRB(
            16,
            0,
            16,
            MediaQuery.of(context).padding.bottom + 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pemkot Bandung membangun empat insinerator baru atasi masalah sampah",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "13 Nov 2025 08:19 WIB",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/artikel_3.png",
                  width: double.infinity,
                  height: 315,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Wali Kota Bandung Muhammad Farhan saat melakukan peninjauan pengangkutan sampah dari "
                "tempat penampungan sementara (TPS) di Kota Bandung, Jawa Barat, Jumat (14/11/2025). "
                "(ANTARA/Rubby Jovan)\n\n"
                "Kota Bandung (ANTARA) - Pemerintah Kota (Pemkot) Bandung, Jawa Barat, menargetkan "
                "pembangunan empat titik insinerator baru bisa segera beroperasi dalam waktu tiga bulan "
                "ke depan guna mengatasi permasalahan sampah di Kota Kembang.\n\n"
                "\"Paling cepat dua sampai tiga bulan lagi kita bisa operasikan empat insinerator baru. "
                "Tapi memang prosesnya tidak mudah, karena harus lolos sertifikasi dari kementerian. "
                "Kita juga sudah siapkan lewat APBD Perubahan,\" kata Wali Kota Bandung Muhammad Farhan "
                "di Bandung, Jumat.\n\n"
                "Farhan mengungkapkan langkah tersebut dilakukan untuk menangani persoalan sampah, "
                "terutama setelah adanya pembatasan kuota pengangkutan sampah ke Tempat Pembuangan "
                "Akhir (TPA) sejak Oktober lalu.\n\n"
                "Ia menyebut saat ini Kota Bandung hanya bisa mengangkut sekitar 900 ton sampah per hari. "
                "Untuk itu Pemkot Bandung harus memastikan agar tidak ada hambatan dalam proses pengangkutan.\n\n"
                "\"Kita pastikan jangan sampai dari sisa kuota 900 ton ini ada yang terhambat. Kalau sampai "
                "terhambat, antrean sampah di TPS bisa makin panjang,\" ujar Farhan.\n\n"
                "Farhan menerangkan masih ada sejumlah wilayah yang belum memiliki fasilitas pengolahan "
                "sampah yang memadai. Akibatnya, terjadi antrean lebih lama di beberapa titik pembuangan sementara.\n\n"
                "\"Beberapa wilayah memang masih menumpuk, karena fasilitas pengolahan belum terbangun. "
                "Makanya kita perlu pengelolaan bersama-sama antara pemerintah dan masyarakat,\" katanya.\n\n"
                "Ia mengatakan pengangkutan sampah sebanyak 941 ton per hari harus terus berjalan tanpa "
                "hambatan. Jika berhenti sehari saja, tumpukan bisa meningkat drastis.\n\n"
                "\"Sekarang kondisinya sudah mepet sekali. Biasanya Sabtu malam TPS sudah kosong, tapi "
                "sekarang Sabtu malam masih penuh. Itu sebabnya terjadi penumpukan dua sampai tiga hari "
                "sebelum diangkut lagi,\" kata Farhan.\n\n",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isSmall = constraints.maxWidth < 430;

            return Container(
              padding: EdgeInsets.fromLTRB(
                isSmall ? 8 : 12,
                8,
                isSmall ? 8 : 12,
                8,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F3E8),
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFBDD4C0),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmall ? 8 : 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        icon: Icon(
                          Iconsax.message,
                          size: isSmall ? 16 : 18,
                        ),
                        label: Text(
                          isSmall
                              ? "Komentar..."
                              : "Tambahkan komentar...",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isSmall ? 12 : 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isSmall ? 2 : 6),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: isSmall ? 32 : 38,
                      minHeight: 38,
                    ),
                    onPressed: () {
                      setState(() {
                        _isLiked = !_isLiked;
                      });
                    },
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      size: isSmall ? 23 : 26,
                      color: _isLiked ? Colors.red : Colors.black,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: isSmall ? 32 : 38,
                      minHeight: 38,
                    ),
                    onPressed: toggleSaveArticle,
                    icon: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      size: isSmall ? 23 : 26,
                      color: isSaved
                          ? const Color(0xFF3E472D)
                          : Colors.black,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: isSmall ? 32 : 38,
                      minHeight: 38,
                    ),
                    onPressed: () {},
                    icon: Icon(
                      Icons.share,
                      size: isSmall ? 23 : 26,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}