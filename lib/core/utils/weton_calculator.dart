import '../constants/primbon_data_tables.dart';

class WetonResult {
  final DateTime date;
  final String namaHari;
  final String pasaran;
  final int nilaiHari;
  final int nilaiPasaran;
  final int totalNeptu;

  WetonResult({
    required this.date,
    required this.namaHari,
    required this.pasaran,
    required this.nilaiHari,
    required this.nilaiPasaran,
    required this.totalNeptu,
  });
}

class WetonCalculator {
  static final DateTime _epochDate = DateTime(1900, 1, 1);
  static const int _epochPasaranIndex = 1; // 1 Jan 1900 = Senin Pahing

  static String getNamaHari(int weekday) {
    const names = {
      DateTime.monday: 'Senin',
      DateTime.tuesday: 'Selasa',
      DateTime.wednesday: 'Rabu',
      DateTime.thursday: 'Kamis',
      DateTime.friday: 'Jumat',
      DateTime.saturday: 'Sabtu',
      DateTime.sunday: 'Minggu',
    };
    return names[weekday] ?? '';
  }

  static String getPasaran(DateTime date) {
    final difference = date.difference(_epochDate).inDays;
    int pasaranIndex = (difference + _epochPasaranIndex) % 5;
    if (pasaranIndex < 0) pasaranIndex += 5;
    return PrimbonTables.daftarPasaran[pasaranIndex];
  }

  static WetonResult calculate(DateTime date) {
    final cleanDate = DateTime(date.year, date.month, date.day);
    final namaHari = getNamaHari(cleanDate.weekday);
    final pasaran = getPasaran(cleanDate);
    final nHari = PrimbonTables.nilaiHari[cleanDate.weekday] ?? 0;
    final nPasaran = PrimbonTables.nilaiPasaran[pasaran] ?? 0;

    return WetonResult(
      date: cleanDate,
      namaHari: namaHari,
      pasaran: pasaran,
      nilaiHari: nHari,
      nilaiPasaran: nPasaran,
      totalNeptu: nHari + nPasaran,
    );
  }
}
