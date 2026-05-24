import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DailyLoginPage extends StatefulWidget {
  const DailyLoginPage({super.key});

  @override
  State<DailyLoginPage> createState() => _DailyLoginPageState();
}

class _DailyLoginPageState extends State<DailyLoginPage> {
  final SupabaseClient supabase = Supabase.instance.client;

  bool buangSampah = false;
  bool setorBankSampah = false;

  bool sudahKlaimHariIni = false;
  bool isLoading = true;
  bool isSubmitting = false;

  int totalPoints = 0;

  final Color darkGreen = const Color(0xFF344126);
  final Color cream = const Color(0xFFFFF9EA);
  final Color redSoft = const Color(0xFFE86452);
  final Color yellowSoft = const Color(0xFFF3C95C);
  final Color blueSoft = const Color(0xFF4CB6AE);

  @override
  void initState() {
    super.initState();
    loadDailyData();
  }

  String getTodayString() {
    final now = DateTime.now();
    final year = now.year.toString().padLeft(4, '0');
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  int parsePoint(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  Future<void> loadDailyData() async {
    try {
      setState(() {
        isLoading = true;
      });

      final user = supabase.auth.currentUser;

      if (user == null) {
        setState(() {
          isLoading = false;
        });

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User belum login'),
            backgroundColor: Colors.red,
          ),
        );

        return;
      }

      final today = getTodayString();

      final profileData = await supabase
          .from('profiles')
          .select('points')
          .eq('id', user.id)
          .maybeSingle();

      totalPoints = parsePoint(profileData?['points']);

      try {
        final dailyData = await supabase
            .from('daily_checkins')
            .select()
            .eq('user_id', user.id)
            .eq('checkin_date', today)
            .maybeSingle();

        if (dailyData != null) {
          sudahKlaimHariIni = true;
          buangSampah = dailyData['buang_sampah'] == true;
          setorBankSampah = dailyData['setor_bank_sampah'] == true;
        } else {
          sudahKlaimHariIni = false;
          buangSampah = false;
          setorBankSampah = false;
        }
      } catch (dailyError) {
        sudahKlaimHariIni = false;
        buangSampah = false;
        setorBankSampah = false;

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Tabel daily_checkins belum ada. Buat tabelnya dulu di Supabase.',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memuat data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> submitDailyLogin() async {
    if (sudahKlaimHariIni) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kamu sudah klaim poin hari ini'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (!buangSampah || !setorBankSampah) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Checklist semua aktivitas dulu ya'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      setState(() {
        isSubmitting = true;
      });

      final user = supabase.auth.currentUser;

      if (user == null) {
        throw Exception('User belum login');
      }

      final result = await supabase.rpc(
        'claim_daily_checkin',
        params: {
          'p_user_id': user.id,
          'p_buang_sampah': buangSampah,
          'p_setor_bank_sampah': setorBankSampah,
        },
      );

      final Map<String, dynamic> data = Map<String, dynamic>.from(result as Map);

      final bool success = data['success'] == true;
      final String message = data['message']?.toString() ?? 'Selesai';
      final int newTotalPoints = parsePoint(data['total_points']);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: success ? Colors.green : Colors.orange,
        ),
      );

      if (success) {
        setState(() {
          sudahKlaimHariIni = true;
          totalPoints = newTotalPoints;
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal klaim point. Pastikan tabel daily_checkins dan function claim_daily_checkin sudah dibuat. Error: $e',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canSubmit =
        buangSampah && setorBankSampah && !sudahKlaimHariIni && !isSubmitting;

    return Scaffold(
      backgroundColor: darkGreen,
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.23),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    Text(
                      'Sudah buang sampah hari ini?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: cream,
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.25),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.stars_rounded,
                            color: Color(0xFFFFD166),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$totalPoints Point',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    _buildIllustration(),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(28, 30, 28, 30),
                      decoration: BoxDecoration(
                        color: cream,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          _buildChecklistItem(
                            title: 'Membuang sampah di\ntempat sampah',
                            value: buangSampah,
                            onTap: sudahKlaimHariIni
                                ? null
                                : () {
                                    setState(() {
                                      buangSampah = !buangSampah;
                                    });
                                  },
                          ),

                          const SizedBox(height: 22),

                          _buildChecklistItem(
                            title: 'Menyetorkan sampah ke\nbank sampah',
                            value: setorBankSampah,
                            onTap: sudahKlaimHariIni
                                ? null
                                : () {
                                    setState(() {
                                      setorBankSampah = !setorBankSampah;
                                    });
                                  },
                          ),

                          const SizedBox(height: 34),

                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: canSubmit ? submitDailyLogin : null,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: darkGreen,
                                disabledBackgroundColor: sudahKlaimHariIni
                                    ? Colors.green.shade300
                                    : Colors.grey.shade300,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: isSubmitting
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : Text(
                                      sudahKlaimHariIni
                                          ? 'Sudah Klaim Hari Ini'
                                          : 'Submit & Dapatkan 5 Point',
                                      style: TextStyle(
                                        color: sudahKlaimHariIni
                                            ? Colors.white
                                            : canSubmit
                                                ? Colors.white
                                                : Colors.grey.shade700,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            sudahKlaimHariIni
                                ? 'Kamu sudah mendapatkan reward hari ini. Balik lagi besok ya!'
                                : 'Checklist semua aktivitas untuk mendapatkan 5 point.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: darkGreen.withOpacity(0.78),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildChecklistItem({
    required String title,
    required bool value,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? darkGreen : Colors.transparent,
              border: Border.all(
                color: darkGreen,
                width: 2,
              ),
            ),
            child: Icon(
              Icons.check_rounded,
              color: value ? Colors.white : darkGreen.withOpacity(0.22),
              size: 28,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: darkGreen,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    return SizedBox(
      height: 245,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 28,
            left: 44,
            child: _buildFloatingTrash(
              color: redSoft,
              icon: Icons.eco_rounded,
              angle: -0.35,
            ),
          ),

          Positioned(
            top: 42,
            right: 48,
            child: _buildFloatingTrash(
              color: yellowSoft,
              icon: Icons.recycling_rounded,
              angle: 0.28,
            ),
          ),

          Positioned(
            top: 94,
            right: 26,
            child: _buildFloatingTrash(
              color: blueSoft,
              icon: Icons.delete_rounded,
              angle: -0.15,
            ),
          ),

          Positioned(
            bottom: 48,
            left: 38,
            child: _buildFloatingTrash(
              color: blueSoft,
              icon: Icons.delete_outline_rounded,
              angle: 0.35,
            ),
          ),

          Positioned(
            bottom: 26,
            right: 50,
            child: _buildFloatingTrash(
              color: redSoft,
              icon: Icons.eco_rounded,
              angle: 0.18,
            ),
          ),

          Positioned(
            top: 64,
            left: 20,
            child: _buildCloud(),
          ),

          Positioned(
            top: 82,
            right: 3,
            child: _buildCloud(),
          ),

          Positioned(
            bottom: 68,
            left: 0,
            child: _buildCloud(),
          ),

          Positioned(
            bottom: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 84,
                  height: 148,
                  decoration: BoxDecoration(
                    color: blueSoft,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(17),
                      topRight: Radius.circular(17),
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.recycling_rounded,
                      color: darkGreen,
                      size: 45,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                SizedBox(
                  width: 110,
                  height: 190,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 28,
                        child: Container(
                          width: 27,
                          height: 103,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7D79B),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 27,
                        child: Container(
                          width: 27,
                          height: 103,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7D79B),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 90,
                        child: Container(
                          width: 78,
                          height: 84,
                          decoration: BoxDecoration(
                            color: redSoft,
                            borderRadius: BorderRadius.circular(19),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 150,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFC0B3),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 174,
                        child: Container(
                          width: 54,
                          height: 25,
                          decoration: BoxDecoration(
                            color: const Color(0xFF222222),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 120,
                        left: 0,
                        child: Transform.rotate(
                          angle: -0.75,
                          child: Container(
                            width: 78,
                            height: 16,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFC0B3),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingTrash({
    required Color color,
    required IconData icon,
    required double angle,
  }) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 38,
        height: 27,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(
          icon,
          size: 16,
          color: darkGreen,
        ),
      ),
    );
  }

  Widget _buildCloud() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: 19,
          decoration: BoxDecoration(
            color: cream,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
        ),
        Container(
          width: 38,
          height: 29,
          decoration: BoxDecoration(
            color: cream,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
        ),
      ],
    );
  }
}