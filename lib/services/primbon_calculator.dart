library primbon_calculator;

class PrimbonCalculator {
  static String getWeton(DateTime date) {
    const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    const pasarans = ['Legi', 'Pahing', 'Pon', 'Wage', 'Kliwon'];
    
    int epochDays = date.difference(DateTime(1900, 1, 1)).inDays;
    String dayName = days[(date.weekday - 1) % 7];
    String pasaranName = pasarans[(epochDays + 1) % 5];
    
    return '$dayName $pasaranName';
  }

  static int hitungNeptu(DateTime date) {
    int dayVal = (date.weekday % 7) + 1;
    int epochDays = date.difference(DateTime(1900, 1, 1)).inDays;
    int pasaranVal = ((epochDays + 1) % 5) + 1;
    return dayVal + pasaranVal;
  }

  static Map<String, String> hitungKecocokanJodoh(int neptuPria, int neptuWanita) {
    int total = neptuPria + neptuWanita;
    String kategori = 'Pegat';
    
    int sisa = total % 9;
    if (sisa == 1 || sisa == 3 || sisa == 6 || sisa == 7) {
      kategori = 'Ratu / Jodoh';
    } else if (sisa == 2 || sisa == 4 || sisa == 8) {
      kategori = 'Jodoh / Padu';
    }

    return {
      'kategori': kategori,
      'deskripsi': 'Hasil kecocokan berdasarkan neptu total $total ($kategori).'
    };
  }
}
