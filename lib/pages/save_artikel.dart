import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trashsmart/pages/artikel1_page.dart';
import 'package:trashsmart/pages/artikel2_page.dart';
import 'package:trashsmart/pages/artikel3_page.dart';

class SavedArticlesPage extends StatelessWidget {
  const SavedArticlesPage({super.key});

  void openArticle(BuildContext context, String articleId) {

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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final supabase = Supabase.instance.client;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F3E8),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F3E8),
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

      body: FutureBuilder(
        future: supabase
            .from('saved_articles')
            .select()
            .eq(
          'user_id',
          supabase.auth.currentUser!.id,
        ),

        builder: (context, snapshot) {

          // LOADING
          if (!snapshot.hasData) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final articles = snapshot.data!;

          // KOSONG
          if (articles.isEmpty) {

            return Center(
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
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F4F44),
                    ),
                  ),

                  SizedBox(height: 10),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                    ),

                    child: Text(
                      'Artikel yang kamu simpan akan muncul di sini.\nTekan ikon bookmark pada artikel untuk menyimpannya.',
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // ADA DATA
          return ListView.builder(
            itemCount: articles.length,

            itemBuilder: (context, index) {

              final article = articles[index];

              return GestureDetector(

                onTap: () {

                  openArticle(
                    context,
                    article['article_id'],
                  );
                },

                child: Card(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(10),

                  child: Row(
                    children: [

                      // IMAGE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),

                        child: Image.asset(
                          article['image'],
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 14),

                      // TITLE
                      Expanded(
                        child: Text(
                          article['title'],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,

                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  ),
              );
            },
          );
        },
      ),
    );
  }
}