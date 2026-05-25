import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:trashsmart/pages/artikel1_page.dart';
import 'package:trashsmart/pages/artikel2_page.dart';
import 'package:trashsmart/pages/artikel3_page.dart';

class SavedArticlesPage extends StatefulWidget {
  const SavedArticlesPage({super.key});

  @override
  State<SavedArticlesPage> createState() => _SavedArticlesPageState();
}

class _SavedArticlesPageState extends State<SavedArticlesPage> {
  final SupabaseClient supabase = Supabase.instance.client;

  late Future<List<Map<String, dynamic>>> savedArticlesFuture;

  final Color darkGreen = const Color(0xFF3F4F44);
  final Color cream = const Color(0xFFF8F3E8);

  @override
  void initState() {
    super.initState();
    savedArticlesFuture = loadSavedArticles();
  }

  Future<List<Map<String, dynamic>>> loadSavedArticles() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      return [];
    }

    final data = await supabase
        .from('saved_articles')
        .select()
        .eq('user_id', user.id);

    return List<Map<String, dynamic>>.from(data);
  }

  void refreshSavedArticles() {
    setState(() {
      savedArticlesFuture = loadSavedArticles();
    });
  }

  Future<void> openArticle(BuildContext context, String articleId) async {
    Widget page;

    switch (articleId) {
      case 'artikel_1':
        page = const Artikel1Page();
        break;

      case 'artikel_2':
        page = const Artikel2Page();
        break;

      case 'artikel_3':
        page = const Artikel3Page();
        break;

      default:
        return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );

    refreshSavedArticles();
  }

  Future<void> showDeleteConfirm({
    required String articleId,
    required String title,
  }) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: cream,
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
                  "Hapus Artikel?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26351F),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Artikel \"$title\" akan dihapus dari daftar simpan kamu.",
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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
                          side: BorderSide(
                            color: darkGreen,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "Batal",
                          style: TextStyle(
                            color: darkGreen,
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
                          elevation: 0,
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
      await deleteSavedArticle(articleId);
    }
  }

  Future<void> deleteSavedArticle(String articleId) async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        return;
      }

      await supabase
          .from('saved_articles')
          .delete()
          .eq('user_id', user.id)
          .eq('article_id', articleId);

      if (!mounted) return;

      refreshSavedArticles();

      showDeletedDialog();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal menghapus artikel: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showDeletedDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: cream,
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
                    Icons.check_rounded,
                    color: Colors.red,
                    size: 56,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  "Artikel Dihapus",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26351F),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Artikel sudah tidak ada di daftar simpan kamu.",
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
                      backgroundColor: darkGreen,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
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

  Widget emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.bookmark_border_rounded,
              size: 90,
              color: Color(0xFF3F4F44),
            ),

            SizedBox(height: 20),

            Text(
              'Belum Ada Artikel Tersimpan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4F44),
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Artikel yang kamu simpan akan muncul di sini.\nTekan ikon bookmark pada artikel untuk menyimpannya.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget savedArticleCard(Map<String, dynamic> article) {
    final String articleId = article['article_id']?.toString() ?? '';
    final String title = article['title']?.toString() ?? 'Artikel';
    final String image = article['image']?.toString() ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          openArticle(context, articleId);
        },
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: image.isNotEmpty
                    ? Image.asset(
                        image,
                        width: 92,
                        height: 92,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 92,
                        height: 92,
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          color: Colors.grey.shade500,
                        ),
                      ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                        height: 1.35,
                        color: Color(0xFF26351F),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: const [
                        Icon(
                          Icons.bookmark_rounded,
                          color: Color(0xFF3F4F44),
                          size: 17,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Tersimpan",
                          style: TextStyle(
                            color: Color(0xFF3F4F44),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 6),

              IconButton(
                tooltip: 'Hapus dari simpan',
                onPressed: () {
                  showDeleteConfirm(
                    articleId: articleId,
                    title: title,
                  );
                },
                icon: const Icon(
                  Icons.bookmark_remove_rounded,
                  color: Colors.red,
                  size: 27,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,

      appBar: AppBar(
        backgroundColor: cream,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Artikel Tersimpan',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: savedArticlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: darkGreen,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Gagal memuat artikel tersimpan:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }

          final articles = snapshot.data ?? [];

          if (articles.isEmpty) {
            return emptyState();
          }

          return RefreshIndicator(
            color: darkGreen,
            onRefresh: () async {
              refreshSavedArticles();
              await savedArticlesFuture;
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];

                return savedArticleCard(article);
              },
            ),
          );
        },
      ),
    );
  }
}