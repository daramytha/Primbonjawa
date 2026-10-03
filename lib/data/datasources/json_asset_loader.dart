import 'dart:convert';
import 'package:flutter/services.dart';

class JsonAssetLoader {
  static Future<Map<String, dynamic>> loadWatakData() async {
    final String response = await rootBundle.loadString('assets/data/watak_data.json');
    return json.decode(response);
  }

  static Future<List<dynamic>> loadJodohData() async {
    final String response = await rootBundle.loadString('assets/data/jodoh_data.json');
    return json.decode(response);
  }
}
