import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Artikel1Page extends StatefulWidget {
  const Artikel1Page({super.key});

  @override
  State<Artikel1Page> createState() => _Artikel1PageState();
}

class _Artikel1PageState extends State<Artikel1Page> {
  bool _isLiked = false;
  bool isSaved = false;
  bool isRewardClaimed = false;
  bool _dialogShowing = false;

  int likeCount = 0;
  int commentCount = 0;

  bool isLoadingComments = false;
  List<Map<String, dynamic>> comments = [];

  final supabase = Supabase.instance.client;
  final ScrollController _scrollController = ScrollController();

  static const int rewardPoint = 20;

  static const String articleId = 'artikel_1';
  static const String articleTitle =
      'Pertemuan bilateral Indonesia - Norwegia bahas solusi sampah plastik';
  static const String articleImage = 'assets/artikel_1.png';
  static const String articleDate = 'Kamis, 13 November 2025';

  Future<void> claimArticleReward() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      final existing = await supabase
          .from('article_rewards')
          .select()
          .eq('user_id', user.id)
          .eq('article_id', articleId);

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
        'article_id': articleId,
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

  void showSavedDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFFF8F3E8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.bookmark_added_rounded,
                    color: Color(0xFF3E472D),
                    size: 56,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "Artikel Berhasil Disimpan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26351F),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Artikel ini sudah masuk ke daftar simpan kamu.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 22),
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
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Oke",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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

  void showUnsavedDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFFF8F3E8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.bookmark_remove_rounded,
                    color: Colors.red,
                    size: 56,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "Artikel Dihapus dari Simpan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26351F),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Artikel ini sudah tidak ada di daftar simpan kamu.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 22),
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
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Oke",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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

  Future<void> showDeleteCommentConfirm(
    dynamic commentId,
    StateSetter modalSetState,
  ) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFFF8F3E8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                    size: 56,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "Hapus Komentar?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26351F),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Komentar yang dihapus tidak bisa dikembalikan.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(
                            color: Color(0xFF3E472D),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Batal",
                          style: TextStyle(
                            color: Color(0xFF3E472D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Hapus",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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

    if (confirm == true) {
      await deleteComment(commentId);

      if (!mounted) return;

      modalSetState(() {});
    }
  }

  Future<void> checkRewardStatus() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final existing = await supabase
        .from('article_rewards')
        .select()
        .eq('user_id', user.id)
        .eq('article_id', articleId);

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
        .eq('article_id', articleId);

    if (mounted) {
      setState(() {
        isSaved = existing.isNotEmpty;
      });
    }
  }

  Future<void> checkLikedStatus() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      final existing = await supabase
          .from('article_likes')
          .select()
          .eq('user_id', user.id)
          .eq('article_id', articleId);

      if (!mounted) return;

      setState(() {
        _isLiked = existing.isNotEmpty;
      });
    } catch (e) {
      debugPrint("ERROR CHECK LIKE: $e");
    }
  }

  Future<void> loadLikeCount() async {
    try {
      final data = await supabase
          .from('article_likes')
          .select('id')
          .eq('article_id', articleId);

      if (!mounted) return;

      setState(() {
        likeCount = data.length;
      });
    } catch (e) {
      debugPrint("ERROR LOAD LIKE COUNT: $e");
    }
  }

  Future<void> loadComments() async {
    try {
      if (mounted) {
        setState(() {
          isLoadingComments = true;
        });
      }

      final data = await supabase
          .from('article_comments')
          .select('id, user_id, username, comment, created_at')
          .eq('article_id', articleId)
          .order('created_at', ascending: true);

      final List<Map<String, dynamic>> result =
          List<Map<String, dynamic>>.from(data);

      if (!mounted) return;

      setState(() {
        comments = result;
        commentCount = result.length;
        isLoadingComments = false;
      });
    } catch (e) {
      debugPrint("ERROR LOAD COMMENTS: $e");

      if (!mounted) return;

      setState(() {
        isLoadingComments = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memuat komentar: $e")),
      );
    }
  }

  Future<String> getCurrentUsername(String userId) async {
    try {
      final profile = await supabase
          .from('profiles')
          .select('username')
          .eq('id', userId)
          .maybeSingle();

      final username = profile?['username']?.toString().trim();

      if (username != null && username.isNotEmpty) {
        return username;
      }

      return "User";
    } catch (e) {
      debugPrint("ERROR GET USERNAME: $e");
      return "User";
    }
  }

  Future<void> sendComment(String text) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login dulu untuk komentar")),
      );
      return;
    }

    final commentText = text.trim();

    if (commentText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Komentar tidak boleh kosong")),
      );
      return;
    }

    if (commentText.length > 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Komentar maksimal 500 karakter")),
      );
      return;
    }

    try {
      final username = await getCurrentUsername(user.id);

      await supabase.from('article_comments').insert({
        'user_id': user.id,
        'article_id': articleId,
        'username': username,
        'comment': commentText,
      });

      await loadComments();
    } catch (e) {
      debugPrint("ERROR SEND COMMENT: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengirim komentar: $e")),
      );
    }
  }

  Future<void> deleteComment(dynamic commentId) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      await supabase
          .from('article_comments')
          .delete()
          .eq('id', commentId)
          .eq('user_id', user.id);

      await loadComments();
    } catch (e) {
      debugPrint("ERROR DELETE COMMENT: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menghapus komentar: $e")),
      );
    }
  }

  String formatCommentTime(dynamic rawTime) {
    try {
      final date = DateTime.parse(rawTime.toString()).toLocal();

      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      final year = date.year.toString();
      final hour = date.hour.toString().padLeft(2, '0');
      final minute = date.minute.toString().padLeft(2, '0');

      return "$day/$month/$year $hour:$minute";
    } catch (_) {
      return "";
    }
  }

  Future<void> showCommentsSheet() async {
    final TextEditingController commentController = TextEditingController();

    await loadComments();

    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (modalContext, modalSetState) {
            final user = supabase.auth.currentUser;
            final bottomInset = MediaQuery.of(modalContext).viewInsets.bottom;

            return Padding(
              padding: EdgeInsets.only(bottom: bottomInset),
              child: Container(
                height: MediaQuery.of(modalContext).size.height * 0.82,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F3E8),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: 44,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: [
                          const Text(
                            "Komentar",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF26351F),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3E472D).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              "$commentCount",
                              style: const TextStyle(
                                color: Color(0xFF3E472D),
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Navigator.pop(sheetContext);
                            },
                            icon: const Icon(Icons.close_rounded),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: isLoadingComments
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF3E472D),
                              ),
                            )
                          : comments.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(18),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.chat_bubble_outline_rounded,
                                            color: Color(0xFF3E472D),
                                            size: 44,
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        const Text(
                                          "Belum ada komentar",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        const Text(
                                          "Jadilah yang pertama memberi komentar.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.fromLTRB(
                                    18,
                                    14,
                                    18,
                                    14,
                                  ),
                                  itemCount: comments.length,
                                  itemBuilder: (context, index) {
                                    final item = comments[index];
                                    final isMine =
                                        item['user_id'] == user?.id;

                                    final username =
                                        item['username']?.toString() ?? 'User';

                                    final firstLetter =
                                        username.trim().isNotEmpty
                                            ? username
                                                .trim()[0]
                                                .toUpperCase()
                                            : 'U';

                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(18),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
                                            blurRadius: 10,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 19,
                                            backgroundColor:
                                                Colors.green.shade100,
                                            child: Text(
                                              firstLetter,
                                              style: const TextStyle(
                                                color: Color(0xFF3E472D),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        username,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color:
                                                              Color(0xFF26351F),
                                                        ),
                                                      ),
                                                    ),
                                                    if (isMine)
                                                      GestureDetector(
                                                        onTap: () async {
                                                          await showDeleteCommentConfirm(
                                                            item['id'],
                                                            modalSetState,
                                                          );
                                                        },
                                                        child: const Icon(
                                                          Icons
                                                              .delete_outline_rounded,
                                                          size: 19,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  item['comment']?.toString() ??
                                                      '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    height: 1.35,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  formatCommentTime(
                                                    item['created_at'],
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.grey.shade600,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F3E8),
                        border: Border(
                          top: BorderSide(
                            color: Colors.black12,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              minLines: 1,
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: "Tulis komentar...",
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () async {
                              final text = commentController.text;

                              FocusManager.instance.primaryFocus?.unfocus();

                              await sendComment(text);

                              commentController.clear();

                              if (!mounted) return;

                              modalSetState(() {});
                            },
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3E472D),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    // Jangan dispose commentController di sini.
  }

  Future<void> toggleLikeArticle() async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login dulu untuk menyukai artikel")),
        );
        return;
      }

      if (_isLiked) {
        await supabase
            .from('article_likes')
            .delete()
            .eq('user_id', user.id)
            .eq('article_id', articleId);

        if (!mounted) return;

        setState(() {
          _isLiked = false;
        });

        await loadLikeCount();
      } else {
        await supabase.from('article_likes').insert({
          'user_id': user.id,
          'article_id': articleId,
        });

        if (!mounted) return;

        setState(() {
          _isLiked = true;
        });

        await loadLikeCount();
      }
    } catch (e) {
      debugPrint("ERROR TOGGLE LIKE: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal mengubah like: $e"),
        ),
      );
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
          .eq('article_id', articleId);

      if (!mounted) return;

      setState(() {
        isSaved = false;
      });

      showUnsavedDialog();
    } else {
      await supabase.from('saved_articles').insert({
        'user_id': user.id,
        'article_id': articleId,
        'title': articleTitle,
        'image': articleImage,
      });

      if (!mounted) return;

      setState(() {
        isSaved = true;
      });

      showSavedDialog();
    }
  }

  Future<void> shareArticle(BuildContext shareButtonContext) async {
    try {
      final box = shareButtonContext.findRenderObject() as RenderBox?;

      await SharePlus.instance.share(
        ShareParams(
          title: articleTitle,
          subject: articleTitle,
          text:
              "Baca artikel ini di TrashSmart:\n\n$articleTitle\n\n$articleDate\n\nYuk baca info lingkungan dan pengelolaan sampah di aplikasi TrashSmart(link download comingsoon).",
          sharePositionOrigin: box != null
              ? box.localToGlobal(Offset.zero) & box.size
              : const Rect.fromLTWH(0, 0, 1, 1),
        ),
      );
    } catch (e) {
      debugPrint("ERROR SHARE ARTICLE: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal membagikan artikel: $e")),
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
    await checkLikedStatus();
    await loadLikeCount();
    await loadComments();

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

  Widget _bottomActionItem({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
    String? countText,
    required bool isSmall,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: isSmall ? 64 : 74,
        height: 52,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: isSmall ? 24 : 27,
              color: color,
            ),
            if (countText != null) ...[
              const SizedBox(height: 2),
              Text(
                countText,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ],
          ],
        ),
      ),
    );
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
                articleTitle,
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
                      articleDate,
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
                  articleImage,
                  width: double.infinity,
                  height: 315,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Belém (ANTARA) - Menteri Lingkungan Hidup Hanif Faisol Nurofiq melakukan pertemuan bilateral "
                "dengan Menteri Iklim dan Lingkungan Hidup Norwegia, Andreas Bjelland Eriksen, untuk membahas "
                "penanganan sampah plastik.\n\n"
                "\"Membahas kesiapan Indonesia untuk menjadi lead di dalam langkah penanganan polusi plastik,\" kata "
                "Menteri Hanif Faisol Nurofiq di sela-sela pelaksanaan Konferensi Perubahan Iklim PBB ke-30 (COP30) "
                "di Belém, Brasil, Rabu (12/11) waktu setempat.\n\n"
                "Menurut dia, pemerintah Indonesia sangat berkomitmen untuk mengatasi permasalahan sampah plastik "
                "di Tanah Air. \"Indonesia sangat kuat tekad untuk kemudian mengurangi secara bertahap polusi plastik "
                "di Tanah Air. Kita negara besar tentu memiliki timbulan sampah yang cukup besar,\" katanya.\n\n"
                "Pihaknya mencatat Indonesia menghasilkan 143 ribu ton sampah per hari. Dari jumlah tersebut, sekitar "
                "12 hingga 17 persennya merupakan sampah plastik. \"Dari 143 ribu ton (sampah) per hari, 12 - 17 persennya "
                "merupakan sampah plastik yang sudah sekian tahun belum bisa kita tangani dengan serius,\" katanya.\n\n"
                "Hanif Faisol Nurofiq pun menekankan penanganan permasalahan sampah plastik harus melibatkan banyak pihak "
                "sehingga penanganannya bisa dilakukan secara masif, terukur, dan sistematis. \"Sehingga apa yang diminta oleh "
                "Bapak Presiden melalui Peraturan Presiden Nomor 12 Tahun 2025 tentang Rencana Pembangunan Jangka Menengah "
                "Nasional (RPJMN), Indonesia akan mampu menyelesaikan penanganan sampah selesai 100 persen di tahun 2029,\" "
                "katanya.\n\n"
                "Selain melakukan pertemuan bilateral dengan Pemerintah Norwegia, Menteri Lingkungan Hidup Hanif Faisol "
                "Nurofiq juga melakukan pertemuan bilateral dengan Menteri Lingkungan Hidup, Pembangunan Berkelanjutan "
                "Republik Kongo, Arlette Soudan-Nonaul untuk memulihkan lahan gambut.\n\n"
                "Belém (ANTARA) - Menteri Lingkungan Hidup (LH) Hanif Faisol Nurofiq melakukan pertemuan bilateral "
                "dengan Menteri Lingkungan Hidup, Pembangunan Berkelanjutan Republik Kongo, Arlette Soudan-Nonaul "
                "untuk memulihkan lahan gambut.\n\n"
                "\"Kita sudah setuju untuk membangun forum dalam rangka melakukan restorasi tropical peatland di negara "
                "masing-masing dengan joint collaboration, dan kemudian melakukan penguatan-penguatan sehingga akan mampu "
                "memiliki karbon yang berintegritas dan daya tawar yang tinggi pada masyarakat global dalam upaya penurunan "
                "emisi gas rumah kaca,\" kata Menteri LH Hanif Faisol Nurofiq di sela-sela pelaksanaan Konferensi Perubahan "
                "Iklim PBB ke-30 (COP30) di Belém, Brasil, Rabu (12/11) waktu setempat.\n\n"
                "Ia mengatakan nantinya Indonesia akan membuat kesepakatan bersama dengan tiga negara, yakni Republik Kongo, "
                "Republik Demokratik Kongo, dan Peru, terkait dengan restorasi gambut.\n\n",
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _bottomActionItem(
                    icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                    onPressed: toggleLikeArticle,
                    color: _isLiked ? Colors.red : Colors.black,
                    countText: '$likeCount',
                    isSmall: isSmall,
                  ),
                  _bottomActionItem(
                    icon: Icons.chat_bubble_outline_rounded,
                    onPressed: showCommentsSheet,
                    color: Colors.black,
                    countText: '$commentCount',
                    isSmall: isSmall,
                  ),
                  _bottomActionItem(
                    icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
                    onPressed: toggleSaveArticle,
                    color: isSaved ? const Color(0xFF3E472D) : Colors.black,
                    isSmall: isSmall,
                  ),
                  Builder(
                    builder: (shareButtonContext) {
                      return _bottomActionItem(
                        icon: Icons.share,
                        onPressed: () {
                          shareArticle(shareButtonContext);
                        },
                        color: Colors.black,
                        isSmall: isSmall,
                      );
                    },
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