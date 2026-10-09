import 'package:flutter/material.dart';
import '../../services/primbon_calculator.dart';

class WetonScreen extends StatefulWidget {
  const WetonScreen({super.key});

  @override
  State<WetonScreen> createState() => _WetonScreenState();
}

class _WetonScreenState extends State<WetonScreen> {
  DateTime _selectedDate = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    final weton = PrimbonCalculator.getWeton(_selectedDate);
    final neptu = PrimbonCalculator.hitungNeptu(_selectedDate);
    final hijri = _getHijriDate(_selectedDate);

    final List<String> namaBulan = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    final List<String> namaHari = [
      'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
    ];

    final hari = namaHari[_selectedDate.weekday - 1];
    final bulan = namaBulan[_selectedDate.month - 1];
    final tanggalFormatted = '$hari, ${_selectedDate.day} $bulan ${_selectedDate.year}';

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Hitung Weton & Neptu'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Tanggal Dipilih:\n$tanggalFormatted\n($hijri)',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF3E2723),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E2723),
                foregroundColor: const Color(0xFFFFD700),
              ),
              icon: const Icon(Icons.date_range),
              label: const Text('Pilih Tanggal Lahir'),
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
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Weton: $weton',
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Neptu: $neptu',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
