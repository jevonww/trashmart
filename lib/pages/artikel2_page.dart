import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Artikel2Page extends StatefulWidget {
  const Artikel2Page({super.key});
  @override
  State<Artikel2Page> createState() => _Artikel2PageState();
}

class _Artikel2PageState extends State<Artikel2Page> {
  bool _isLiked = false;
  bool isSaved = false;

  final supabase =
      Supabase.instance.client;

  final ScrollController
  _scrollController =
  ScrollController();

  bool isRewardClaimed = false;

  // GANTI POIN
  static const int rewardPoint = 20;

  Future<void> claimArticleReward() async {

    try {

      final user = supabase.auth.currentUser;

      if (user == null) {
        return;
      }

      // CEK APAKAH SUDAH CLAIM
      final existing = await supabase
          .from('article_rewards')
          .select()
          .eq('user_id', user.id)
          .eq('article_id', 'artikel_2');

      if (existing.isNotEmpty) {

        print("SUDAH CLAIM");

        return;
      }

      // AMBIL PROFILE USER
      final profile = await supabase
          .from('profiles')
          .select('points')
          .eq('id', user.id)
          .maybeSingle();

      // JIKA PROFILE BELUM ADA
      if (profile == null) {

        await supabase
            .from('profiles')
            .insert({
          'id': user.id,
          'points': 0,
        });

        print("PROFILE CREATED");
      }

      // AMBIL ULANG PROFILE
      final updatedProfile = await supabase
          .from('profiles')
          .select('points')
          .eq('id', user.id)
          .single();

      int currentPoint =
          updatedProfile['points'] ?? 0;

      print("POINT SEKARANG:");
      print(currentPoint);

      // UPDATE POINT
      await supabase
          .from('profiles')
          .update({
        'points': currentPoint + rewardPoint,
      })
          .eq('id', user.id);

      print("POINT UPDATED");

      // INSERT HISTORY REWARD
      await supabase
          .from('article_rewards')
          .insert({
        'user_id': user.id,
        'article_id': 'artikel_2',
      });

      print("REWARD INSERTED");

    } catch (e) {

      print("ERROR:");
      print(e);
    }
  }

  // POPUP CLAIM
  Future<void> showClaimDialog() async {

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

                // ICON
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.card_giftcard,
                    color: const Color(0xFF3E472D),
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
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                        ),

                        child: const Text(
                          "Batal",
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {

                          Navigator.pop(context);

                          await claimArticleReward();

                          final user =
                              supabase.auth.currentUser;

                          final profile = await supabase
                              .from('profiles')
                              .select('points')
                              .eq('id', user!.id)
                              .single();

                          int totalPoint =
                          profile['points'];

                          showSuccessDialog(
                            totalPoint,
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3E472D),
                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 14,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                        ),

                        child: const Text(
                          "Klaim",
                          style: TextStyle(
                            color: Colors.white,
                          ),
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
  }

  // POPUP BERHASIL
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
                    color: const Color(0xFF3E472D),
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 14,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                      ),
                    ),

                    child: const Text(
                      "Lanjut",
                      style: TextStyle(
                        color: Colors.white,
                      ),
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
        .eq('article_id', 'artikel_2');

    if (existing.isNotEmpty) {

      isRewardClaimed = true;
    }
  }

  // SAVE ARTIKEL
  Future<void> checkSavedStatus() async {

    final user = supabase.auth.currentUser;

    if (user == null) return;

    final existing = await supabase
        .from('saved_articles')
        .select()
        .eq('user_id', user.id)
        .eq('article_id', 'artikel_2');

    if (existing.isNotEmpty) {

      setState(() {
        isSaved = true;
      });
    }
  }

  Future<void> toggleSaveArticle() async {

    final user = supabase.auth.currentUser;

    if (user == null) return;

    if (isSaved) {

      // HAPUS SAVE
      await supabase
          .from('saved_articles')
          .delete()
          .eq('user_id', user.id)
          .eq('article_id', 'artikel_2');

      setState(() {
        isSaved = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Artikel dihapus dari simpan"),
        ),
      );

    } else {

      // SAVE ARTIKEL
      await supabase
          .from('saved_articles')
          .insert({
        'user_id': user.id,
        'article_id': 'artikel_2',
        'title':
        'Kelola Sampah Tingkat Lokal, Bank Sampah RW 01 Boponter Resmi Beroperasi',
        'image': 'assets/artikel_2.png',
      });

      setState(() {
        isSaved = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Artikel berhasil disimpan"),
        ),
      );
    }
  }

  // INIT STATE
  @override
  void initState() {
    super.initState();

    initReward();
  }

  Future<void> initReward() async {

    await checkRewardStatus();
    await checkSavedStatus();

    _scrollController.addListener(() {

      if (!isRewardClaimed &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 50) {

        isRewardClaimed = true;

        showClaimDialog();
      }
    });
  }


  // DISPOSE
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

        body: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Judul
            const Text(
              "Kelola Sampah Tingkat Lokal, Bank Sampah RW 01 Boponter Resmi Beroperasi",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),

            // Info tanggal
            Row(
              children: const [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 6),
                Text("13 Nov 2025 08:19 WIB",
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
                SizedBox(width: 16),
               
              ],
            ),
            const SizedBox(height: 16),

            // Gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/artikel_2.png",
                height: 315,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            // Isi berita
            const Text(
              "berita.depok.go.id – Sebagai langkah konkret dalam pengelolaan sampah di tingkat lokal, "
                  "Kelurahan Bojong Pondok Terong (Boponter), Kecamatan Cipayung, "
                  "meresmikan Bank Sampah RW 01, Rabu (12/11/25).\n\n"

                  "Beroperasinya Bank Sampah RW 01 Boponter ini sejalan dengan arahan Pemerintah Kota (Pemkot) "
                  "Depok yang tertuang dalam surat edaran terkait pengolahan sampah dari sumbernya.\n\n"

                  "Lurah Boponter, Adi Supriyadi, mengatakan pembentukan bank sampah ini merupakan wujud "
                  "kekompakan warga dalam merespons permasalahan sampah di lingkungan sekitar. "
                  "Kehadirannya juga selaras dengan arahan Pemerintah Kota Depok mengenai pengelolaan sampah di sumbernya.\n\n"

                  "Pembentukan bank sampah ini dimotori oleh kader posyandu serta ibu RW dan RT setempat. Nantinya, "
                  "pengelola bank sampah RW 01 akan menerima sampah nonorganik dan residu, sementara sampah organik "
                  "diangkut ke Unit Pengolahan Sampah (UPS), jelasnya.\n\n"

                  "Ia menambahkan, hasil pengolahan sampah organik yang terproduksi dapat dimanfaatkan "
                  "kembali ke masyarakat untuk dijadikan pupuk tanaman seperti kangkung, bayam, dan sayuran lainnya.\n\n"

                  "\"Target kami adalah mengurangi jumlah sampah yang masuk ke Tempat Pembuangan Akhir (TPA) "
                  "dengan meningkatkan partisipasi masyarakat dalam memilah sampah dari rumah tangga,\" "
                  "tandas Adi Supriyadi.\n\n"

                  "Selain peresmian bank sampah, kegiatan ini juga dirangkaikan dengan panen kangkung di lingkungan sekitar. "
                  "Dengan pelatihan kader, diharapkan program bank sampah dapat berjalan secara mandiri dan konsisten.\n\n"

                  "Sumber: berita.depok.go.id\n\n",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom action bar
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: Color(0xFFF8F3E8), // ← ganti warna di sini
            border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Komentar
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBDD4C0),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Iconsax.message),
                label: const Text("Tambahkan komentar..."),
              ),

              const SizedBox(width: 8),

              Row(
                children: [
                  IconButton(
                    onPressed: () => setState(() => _isLiked = !_isLiked),
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 28,
                      color: _isLiked ? Colors.red : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: toggleSaveArticle,
                    icon: Icon(
                      isSaved
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      size: 28,
                      color: isSaved
                          ? const Color(0xFF3E472D)
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.share, size: 28),
                ],
              ),
            ],
          ),
        )
    );
  }
}
