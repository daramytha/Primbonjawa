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
      appBar: AppBar(title: const Text('Tafsir Mimpi')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              onChanged: (val) => provider.searchTafsir(val),
              decoration: const InputDecoration(
                hintText: 'Cari kata kunci (Ular, Air)...',
                prefixIcon: Icon(Icons.search, color: AppColors.accent),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: provider.tafsirResults.length,
                itemBuilder: (context, index) {
                  final item = provider.tafsirResults[index];
                  return ListTile(
                    title: Text(item['keyword'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(item['tafsir'] ?? ''),
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
