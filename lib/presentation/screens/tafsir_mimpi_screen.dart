import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../providers/primbon_provider.dart';

class TafsirMimpiScreen extends StatelessWidget {
  const TafsirMimpiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrimbonProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Tafsir Mimpi'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              onChanged: (val) => provider.searchTafsir(val),
              decoration: InputDecoration(
                hintText: 'Cari kata kunci (Ular, Air)...',
                prefixIcon: const Icon(Icons.search, color: AppColors.accent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: provider.tafsirResults.isEmpty
                  ? const Center(
                      child: Text(
                        'Tafsir tidak ditemukan',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: provider.tafsirResults.length,
                      itemBuilder: (context, index) {
                        final item = provider.tafsirResults[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(
                              item['keyword'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3E2723),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(item['tafsir'] ?? ''),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
