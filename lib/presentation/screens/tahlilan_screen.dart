import 'package:flutter/material.dart';
import '../services/primbon_calculator.dart';

class TahlilanScreen extends StatefulWidget {
  const TahlilanScreen({super.key});

  @override
  State<TahlilanScreen> createState() => _TahlilanScreenState();
}

class _TahlilanScreenState extends State<TahlilanScreen> {
  DateTime _selectedDate = DateTime.now();

  // Hari H dihitung sebagai hari ke-1
  DateTime _calculateDate(int days) {
    return _selectedDate.add(Duration(days: days - 1));
  }

  // Mendak 1 dan Mendak 2 berdasarkan siklus tahunan/weton Jawa
  DateTime _calculateMendakWeton(int years) {
    int targetDays = years == 1 ? 354 : (354 * 2); 
    return _selectedDate.add(Duration(days: targetDays));
  }

  // Konversi Masehi ke Hijriyah sederhana
  String _getHijriDate(DateTime date) {
    int julianDay = (date.millisecondsSinceEpoch / (1000 * 60 * 60 * 24)).floor() + 2440588;
    int l = julianDay - 1948440 + 10632;
    int n = ((l - 1) / 10651).floor();
    l = l - (10651 * n + 325).floor();
    int j = ((10 + 11 * l) / 330).floor();
    int day = l - ((33 * j + 3) / 11).floor() + 1;
    int month = ((j / 12) + 1).floor();
    int year = (30 * n + j - 30).floor();

    const monthsHijri = [
      'Muharram', 'Safar', 'Rabiul Awal', 'Rabiul Akhir',
      'Jumadil Awal', 'Jumadil Akhir', 'Rajab', 'Sya\'ban',
      'Ramadhan', 'Syawal', 'Dzulqa\'dah', 'Dzulhijjah'
    ];

    if (month < 1 || month > 12) return '1 Muharram $year H';
    return '$day ${monthsHijri[month - 1]} $year H';
  }

  String _formatDate(DateTime date) {
    final List<String> namaBulan = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    final List<String> namaHari = [
      'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
    ];

    final hari = namaHari[date.weekday - 1];
    final bulan = namaBulan[date.month - 1];
    final weton = PrimbonCalculator.getWeton(date);
    final hijri = _getHijriDate(date);

    return '$hari, ${date.day} $bulan ${date.year}\n($hijri)\nWeton: $weton';
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> peringatanList = [
      {
        'title': '3 Hari (Telong Dina)',
        'date': _calculateDate(3),
        'desc': 'Peringatan hari ke-3 meninggalnya almarhum/almarhumah.'
      },
      {
        'title': '7 Hari (Pitung Dina)',
        'date': _calculateDate(7),
        'desc': 'Peringatan hari ke-7 (Tahlilan utama seminggu).'
      },
      {
        'title': '40 Hari (Patang Puluh Dina)',
        'date': _calculateDate(40),
        'desc': 'Peringatan hari ke-40 meninggal dunia.'
      },
      {
        'title': '100 Hari (Nyatus Dina)',
        'date': _calculateDate(100),
        'desc': 'Peringatan hari ke-100 meninggal dunia.'
      },
      {
        'title': '1 Tahun / Mendak Pisan (Weton Jawa)',
        'date': _calculateMendakWeton(1),
        'desc': 'Peringatan 1 tahun berdasarkan siklus penanggalan/weton Jawa.'
      },
      {
        'title': '2 Tahun / Mendak Pindo (Weton Jawa)',
        'date': _calculateMendakWeton(2),
        'desc': 'Peringatan 2 tahun berdasarkan siklus penanggalan/weton Jawa.'
      },
      {
        'title': '1000 Hari (Nyewu Dina)',
        'date': _calculateDate(1000),
        'desc': 'Peringatan puncak 1000 hari almarhum/almarhumah.'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Hitung Peringatan Meninggal'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tanggal Meninggal (Hari H):',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(_selectedDate),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3E2723),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3E2723),
                        foregroundColor: const Color(0xFFFFD700),
                      ),
                      icon: const Icon(Icons.edit_calendar, size: 18),
                      label: const Text('Pilih'),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                              child: Localizations.override(
                                context: context,
                                locale: const Locale('id', 'ID'),
                                child: child!,
                              ),
                            );
                          },
                        );
                        if (picked != null) {
                          setState(() => _selectedDate = picked);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: peringatanList.length,
                itemBuilder: (context, index) {
                  final item = peringatanList[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            const Color(0xFF3E2723).withOpacity(0.1),
                        child: const Icon(
                          Icons.event_available,
                          color: Color(0xFF3E2723),
                        ),
                      ),
                      title: Text(
                        item['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _formatDate(item['date']),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD84315),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['desc'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
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
