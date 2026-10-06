class PrimbonCalculator {
  // Daftar Pasaran Jawa
  static const List<String> _pasaranList = [
    'Legi',
    'Pahing',
    'Pon',
    'Wage',
    'Kliwon'
  ];

  // Daftar Hari Masehi
  static const List<String> _hariList = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];

  // Nilai Neptu Hari
  static const Map<int, int> _neptuHari = {
    DateTime.monday: 4,
    DateTime.tuesday: 3,
    DateTime.wednesday: 7,
    DateTime.thursday: 8,
    DateTime.friday: 6,
    DateTime.saturday: 9,
    DateTime.sunday: 5,
  };

  // Nilai Neptu Pasaran (0: Legi, 1: Pahing, dst)
  static const List<int> _neptuPasaran = [5, 9, 7, 4, 8];

  // Method mendapatkan Pasaran berdasarkan tanggal
  static String getPasaran(DateTime date) {
    // Tanggal acuan: 1 Januari 1900 jatuh pada hari Senin Pahing (index pasaran 1)
    final anchorDate = DateTime(1900, 1, 1);
    final difference = date.difference(anchorDate).inDays;
    
    int pasaranIndex = (difference + 1) % 5;
    if (pasaranIndex < 0) {
      pasaranIndex += 5;
    }
    return _pasaranList[pasaranIndex];
  }

  // Method mendapatkan Weton lengkap (misal: "Senin Pahing")
  static String getWeton(DateTime date) {
    final hariIndex = date.weekday - 1;
    final namaHari = _hariList[hariIndex];
    final namaPasaran = getPasaran(date);
    return '$namaHari $namaPasaran';
  }

  // Method menghitung total Neptu (Hari + Pasaran)
  static int hitungNeptu(DateTime date) {
    final neptuH = _neptuHari[date.weekday] ?? 0;
    
    final pasaranStr = getPasaran(date);
    final pasaranIdx = _pasaranList.indexOf(pasaranStr);
    final neptuP = pasaranIdx != -1 ? _neptuPasaran[pasaranIdx] : 0;

    return neptuH + neptuP;
  }

  // Method hitung kecocokan jodoh berdasarkan neptu
  static Map<String, String> hitungKecocokanJodoh(int neptuPria, int neptuWanita) {
    final total = neptuPria + neptuWanita;
    final sisa = total % 8;

    switch (sisa) {
      case 1:
        return {
          'kategori': 'PEGAT',
          'deskripsi': 'Masalah perselisihan atau ekonomi sering muncul dalam rumah tangga.',
        };
      case 2:
        return {
          'kategori': 'RATU',
          'deskripsi': 'Pasangan yang sangat harmonis, disegani tetangga dan lingkungan sekitar.',
        };
      case 3:
        return {
          'kategori': 'JODOH',
          'deskripsi': 'Cocok satu sama lain, bisa menerima kelebihan dan kekurangan pasangan.',
        };
      case 4:
        return {
          'kategori': 'TOPO',
          'deskripsi': 'Awalnya sering mengalami kesukaran, namun akan bahagia di masa mendatang.',
        };
      case 5:
        return {
          'kategori': 'TINARI',
          'deskripsi': 'Akan menemukan kebahagiaan, kemudahan mencari rezeki, dan sering mendapat keberuntungan.',
        };
      case 6:
        return {
          'kategori': 'PADU',
          'deskripsi': 'Sering mengalami pertengkaran untuk hal-hal sepele, namun tidak sampai bercerai.',
        };
      case 7:
        return {
          'kategori': 'SUJANAN',
          'deskripsi': 'Sering mengalami pertengkaran terkait masalah perselingkuhan atau kecemburuan.',
        };
      default:
        return {
          'kategori': 'PESTHI',
          'deskripsi': 'Rukun, tenteram, dan damai sampai tua tanpa kendala berarti.',
        };
    }
  }
}
