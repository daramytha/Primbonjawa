import 'package:flutter/material.dart';

class PrimbonProvider extends ChangeNotifier {
  String _searchQuery = '';

  // Tambahkan method ini agar tidak error di main.dart
  void initData() {
    notifyListeners();
  }

  final List<Map<String, String>> _allTafsir = [
    {
      'keyword': 'Ular',
      'tafsir':
          'Mimpi melihat ular melambangkan adanya rintangan, atau penanda akan datangnya jodoh jika bermimpi digigit ular.',
    },
    {
      'keyword': 'Air Jernih',
      'tafsir':
          'Pertanda keberkahan, ketenangan pikiran, dan rezeki yang lancar serta halal.',
    },
    {
      'keyword': 'Terbang',
      'tafsir':
          'Pertanda keinginan untuk bebas, peningkatan derajat, atau kesuksesan karir.',
    },
  ];

  List<Map<String, String>> get tafsirResults {
    if (_searchQuery.isEmpty) {
      return _allTafsir;
    }
    return _allTafsir.where((item) {
      final keyword = item['keyword']?.toLowerCase() ?? '';
      final tafsir = item['tafsir']?.toLowerCase() ?? '';
      final query = _searchQuery.toLowerCase();
      return keyword.contains(query) || tafsir.contains(query);
    }).toList();
  }

  void searchTafsir(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
