import '../constants/primbon_data_tables.dart';
import 'weton_calculator.dart';

class HariBaikResult {
  final String arahNogoDino; // Timur, Selatan, Barat, Utara
  final String statusHari;   # Rahayu, Sangar, Naas, dll.
  final String saran;

  HariBaikResult({
    required this.arahNogoDino,
    required this.statusHari,
    required this.saran,
  });
}

class HariBaikCalculator {
  // Arah Naga Hari berdasarkan Hari Masehi
  static String getArahNogoDino(int weekday) {
    switch (weekday) {
      case DateTime.sunday:
        return 'Timur';
      case DateTime.monday:
        return 'Selatan';
      case DateTime.tuesday:
        return 'Barat';
      case DateTime.wednesday:
        return 'Utara';
      case DateTime.thursday:
        return 'Timur';
      case DateTime.friday:
        return 'Selatan';
      case DateTime.saturday:
        return 'Barat';
      default:
        return 'Utara';
    }
  }

  // Menentukan kelayakan hari berdasarkan pembagi Neptu Modulo 4
  static HariBaikResult calculate(DateTime date) {
    final weton = WetonCalculator.calculate(date);
    final arah = getArahNogoDino(date.weekday);
    final sisa = weton.totalNeptu % 4;

    String status;
    String saran;

    switch (sisa) {
      case 1:
        status = 'Gusti (Sangat Baik)';
        saran = 'Hari yang sangat baik untuk memulai usaha, hajatan, atau pindah rumah.';
        break;
      case 2:
        status = 'Peting (Baik)';
        saran = 'Cukup baik untuk melaksanakan niat penting, penuh dengan kelancaran.';
        break;
      case 3:
        status = 'Sangar (Netral/Perlu Waspada)';
        saran = 'Sebaiknya hindari keputusan besar. Perbanyak doa dan kehati-hatian.';
        break;
      default:
        status = 'Naas (Hindari)';
        saran = 'Kurang disarankan untuk acara besar/pindahan. Cari hari alternatif lain.';
        break;
    }

    return HariBaikResult(
      arahNogoDino: arah,
      statusHari: status,
      saran: saran,
    );
  }
}
