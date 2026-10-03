import 'package:flutter/material.dart';
import '../../core/utils/weton_calculator.dart';
import '../../data/datasources/json_asset_loader.dart';
import '../../data/datasources/local_db_helper.dart';

class PrimbonProvider extends ChangeNotifier {
  Map<String, dynamic> _watakMap = {};
  List<dynamic> _jodohList = [];
  List<Map<String, dynamic>> _tafsirResults = [];

  List<Map<String, dynamic>> get tafsirResults => _tafsirResults;

  Future<void> initData() async {
    try {
      _watakMap = await JsonAssetLoader.loadWatakData();
      _jodohList = await JsonAssetLoader.loadJodohData();
      _tafsirResults = await LocalDbHelper.searchTafsir('');
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading data: $e");
    }
  }

  Map<String, String> getWatakInfo(int totalNeptu) {
    final key = totalNeptu.toString();
    if (_watakMap.containsKey(key)) {
      return {
        'lakuni': _watakMap[key]['lakuni'] ?? '',
        'watak': _watakMap[key]['watak'] ?? '',
      };
    }
    return {'lakuni': 'Laku Bintang', 'watak': 'Memiliki kepribadian tenang.'};
  }

  Map<String, dynamic> calculateJodoh(WetonResult person1, WetonResult person2) {
    final sumNeptu = person1.totalNeptu + person2.totalNeptu;
    final remainder = sumNeptu % 8;

    final match = _jodohList.firstWhere(
      (element) => element['remainder'] == remainder,
      orElse: () => {
        'category': 'PESTHI',
        'meaning': 'Rumah tangga tenteram.',
        'advice': 'Saling menghormati.'
      },
    );

    return {
      'sumNeptu': sumNeptu,
      'remainder': remainder,
      'category': match['category'],
      'meaning': match['meaning'],
      'advice': match['advice'],
    };
  }

  Future<void> searchTafsir(String query) async {
    _tafsirResults = await LocalDbHelper.searchTafsir(query);
    notifyListeners();
  }
}
