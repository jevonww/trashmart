import 'package:flutter/material.dart';
import 'artikel1_page.dart';
import 'artikel2_page.dart';
import 'artikel3_page.dart';

class TrashNewsPage extends StatelessWidget {
  final ValueChanged<int>? onChangeTab;
  const TrashNewsPage({super.key, this.onChangeTab});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (onChangeTab != null) onChangeTab!(0);
                  else Navigator.pop(context);
                },
              ),
              const SizedBox(width: 6),
              const Text("TrashNews", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          const Text("Update info terbaru seputar lingkungan!", style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 16),

          _newsItem(context, "Pertemuan bilateral Indonesia - Norwegia bahas solusi sampah plastik", "assets/artikel_1.png"),
          _newsItem(context, "Kelola Sampah Tingkat Lokal, Bank Sampah RW 01 Depok Resmi Beroperasi", "assets/artikel_2.png"),
          _newsItem(context, "Pengelolaan Sampah Meningkat di 2025", "assets/artikel_3.png"),

          const SizedBox(height: 60),
        ],
      ),
    );
  }

  // menerima context supaya bisa navigate
  Widget _newsItem(BuildContext context, String title, String imageUrl) {
    Widget _pageForImage() {
      final key = imageUrl.toLowerCase();
      if (key.contains('artikel_1')) return const Artikel1Page();
      if (key.contains('artikel_2')) return const Artikel2Page();
      if (key.contains('artikel_3')) return const Artikel3Page();
      // fallback simple page
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                color: Colors.grey[200],
                child: imageUrl.trim().toLowerCase().startsWith('http')
                    ? Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      )
                    : Image.asset(
                        imageUrl,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => _pageForImage()));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.06), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: Container(
                color: Colors.grey[200],
                child: imageUrl.trim().toLowerCase().startsWith('http')
                    ? Image.network(
                        imageUrl,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      )
                    : Image.asset(
                        imageUrl,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Lihat selengkapnya',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
