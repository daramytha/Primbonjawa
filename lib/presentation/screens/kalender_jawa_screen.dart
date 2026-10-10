import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:primbon_jawa_app/services/primbon_calculator.dart';


class KalenderJawaScreen extends StatefulWidget {
  const KalenderJawaScreen({super.key});

  @override
  State<KalenderJawaScreen> createState() => _KalenderJawaScreenState();
}

class _KalenderJawaScreenState extends State<KalenderJawaScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

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
    final wetonInfo = PrimbonCalculator.getWeton(_selectedDay);
    final neptuInfo = PrimbonCalculator.getNeptu(_selectedDay);
    final hijriInfo = _getHijriDate(_selectedDay);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Kalender Jawa Interaktif'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'id_ID',
            firstDay: DateTime(1900),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0xFF3E2723),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Color(0xFFFFD700),
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(color: Color(0xFF3E2723), fontWeight: FontWeight.bold),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF3E2723),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Informasi Hari Pilihan:',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Weton: $wetonInfo',
                    style: const TextStyle(
                      color: Color(0xFFFFD700),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Nilai Neptu: $neptuInfo',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const Divider(color: Colors.white24, height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.nights_stay, color: Color(0xFFFFD700), size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'Hijriyah: $hijriInfo',
                        style: const TextStyle(
                          color: Color(0xFFFFD700),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
