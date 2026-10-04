import 'package:flutter/material.dart';

class PrimbonProvider extends ChangeNotifier {
  String _searchQuery = '';

  // Master Data Tafsir Mimpi Lengkap
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
    {
      'keyword': 'Pernikahan',
      'tafsir':
          'Pertanda adanya komitmen baru atau fase kehidupan baru yang memerlukan tanggung jawab.',
    },
    {
      'keyword': 'Gigi Copot',
      'tafsir':
          'Peringatan untuk lebih memperhatikan kesehatan diri sendiri atau anggota keluarga.',
    },
    {
      'keyword': 'Api / Kebakaran',
      'tafsir':
          'Pertanda emosi yang memuncak, amarah, atau akan mendapat rezeki besar yang datang mendadak.',
    },
    {
      'keyword': 'Hujan Keruh / Banjir',
      'tafsir':
          'Melambangkan cobaan hidup, ujian emosional, atau masalah finansial yang perlu diwaspadai.',
    },
    {
      'keyword': 'Meninggal Dunia',
      'tafsir':
          'Secara primbon sering diartikan sebagai simbol panjang umur atau awal baru dalam hidup.',
    },
    {
      'keyword': 'Melihat Harimau',
      'tafsir':
          'Pertanda akan mendapatkan penghormatan, disegani orang sekitar, atau diuji oleh pimpinan/atasan.',
    },
    {
      'keyword': 'Melihat Gunung / Memanjat',
      'tafsir':
          'Simbol pencapaian cita-cita, kemudahan dalam karir, dan kedudukan yang tinggi.',
    },
    {
      'keyword': 'Jatuh dari Ketinggian',
      'tafsir':
          'Pertanda rasa cemas, ketakutan akan kegagalan, atau peringatan untuk lebih berhati-hati.',
    },
    {
      'keyword': 'Mendapat Uang',
      'tafsir':
          'Peringatan agar tidak boros atau pertanda akan mendapatkan pengeluaran tak terduga.',
    },
    {
      'keyword': 'Memotong Rambut',
      'tafsir':
          'Pertanda akan ada pembebasan dari beban hidup, masalah yang selesai, atau adanya perpisahan.',
    },
    {
      'keyword': 'Mandi Air Bersih',
      'tafsir':
          'Simbol pembersihan diri dari kesalahan masa lalu, kesembuhan penyakit, dan jiwa yang tenang.',
    },
    {
      'keyword': 'Dikejar Orang / Hewan',
      'tafsir':
          'Menandakan ada tekanan hidup atau tanggung jawab yang sedang dihindari.',
    },
    {
      'keyword': 'Melihat Burung',
      'tafsir':
          'Pertanda datangnya berita baik, kabar gembira dari jauh, atau kebahagiaan keluarga.',
    },
    {
      'keyword': 'Rumah Megah',
      'tafsir':
          'Pertanda kehidupan keuangan yang makin membaik, kestabilan, serta keharmonisan.',
    },
    {
      'keyword': 'Melihat Ikan Besar',
      'tafsir':
          'Pertanda rezeki berlimpah, keberuntungan dagang, atau kesuksesan usaha.',
    },
    {
      'keyword': 'Kehilangan Barang',
      'tafsir':
          'Peringatan untuk lebih waspada terhadap keputusan finansial atau kepercayaan pada orang lain.',
    },
    {
      'keyword': 'Makan Buah Manis',
      'tafsir':
          'Pertanda akan menikmati hasil dari kerja keras yang telah dilakukan selama ini.',
    },
  ];

  // Getter untuk mengambil data tafsir mimpi berdasarkan pencarian
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

  // Method pencarian yang dipanggil saat user mengetik di TextField
  void searchTafsir(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
