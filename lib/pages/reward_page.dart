import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  final supabase = Supabase.instance.client;

  String level = "Smart Rookie";

  // =========================
  // LEVEL
  // =========================

  String getLevel(int points) {
    if (points >= 150) {
      return "Eco Master";
    } else if (points >= 100) {
      return "Green Hero";
    } else if (points >= 50) {
      return "Eco Learner";
    } else {
      return "Smart Rookie";
    }
  }

  // =========================
  // PROGRESS BAR
  // =========================

  double getProgress(int points) {
    if (points >= 150) {
      return 1.0;
    }

    return (points / 150).clamp(0.0, 1.0);
  }

  int parsePoint(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8F3E8),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF8F3E8),
          title: const Text(
            "Reward",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("User belum login"),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E8),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF8F3E8),
        foregroundColor: Colors.black,
        title: const Text(
          "Reward",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      // STREAM PROFILE
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: supabase
            .from('profiles')
            .stream(primaryKey: ['id'])
            .eq('id', user.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Data profile tidak ditemukan"),
            );
          }

          final profile = snapshot.data!.first;

          final int points = parsePoint(profile['points']);

          level = getLevel(points);

          // =========================
          // ARTICLE FUTURE
          // =========================

          return FutureBuilder<List<dynamic>>(
            future: supabase
                .from('article_rewards')
                .select()
                .eq('user_id', user.id),
            builder: (context, articleSnapshot) {
              if (!articleSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              // TOTAL ARTIKEL
              final int totalArticles = articleSnapshot.data!.length;

              // ACHIEVEMENT
              final bool reader1 = totalArticles >= 1;
              final bool reader3 = totalArticles >= 3;
              final bool reader5 = totalArticles >= 10;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // POINT CARD
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF3E472D),
                            Color(0xFF5A6B48),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.stars_rounded,
                            color: Colors.amber,
                            size: 80,
                          ),

                          const SizedBox(height: 15),

                          const Text(
                            "Total Poin",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "$points",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              level,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              value: getProgress(points),
                              minHeight: 12,
                              backgroundColor: Colors.white24,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // =========================
                    // INFO ARTIKEL
                    // =========================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.green.shade100,
                            child: const Icon(
                              Icons.menu_book,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Artikel Dibaca",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  "$totalArticles artikel",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // =========================
                    // ACHIEVEMENT
                    // =========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Achievement",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    achievementCard(
                      title: "Pembaca Pemula",
                      subtitle: "Baca 1 artikel",
                      icon: Icons.menu_book,
                      unlocked: reader1,
                    ),

                    const SizedBox(height: 15),

                    achievementCard(
                      title: "Eco Reader",
                      subtitle: "Baca 3 artikel",
                      icon: Icons.auto_stories,
                      unlocked: reader3,
                    ),

                    const SizedBox(height: 15),

                    achievementCard(
                      title: "Master Reader",
                      subtitle: "Baca 10 artikel",
                      icon: Icons.workspace_premium,
                      unlocked: reader5,
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // =========================
  // ACHIEVEMENT CARD
  // =========================
  Widget achievementCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool unlocked,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor:
                unlocked ? Colors.green.shade100 : Colors.grey.shade300,
            child: Icon(
              icon,
              color: unlocked ? Colors.green : Colors.grey,
              size: 30,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          Icon(
            unlocked ? Icons.check_circle : Icons.lock,
            color: unlocked ? Colors.green : Colors.grey,
          ),
        ],
      ),
    );
  }
}