import 'package:flutter/material.dart';
import '../services/primbon_calculator.dart';

class KalenderJawaScreen extends StatefulWidget {
  const KalenderJawaScreen({super.key});

  @override
  State<KalenderJawaScreen> createState() => _KalenderJawaScreenState();
}

class _KalenderJawaScreenState extends State<KalenderJawaScreen> {
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final weton = PrimbonCalculator.getWeton(_focusedDate);
    final neptu = PrimbonCalculator.hitungNeptu(_focusedDate);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Kalender Jawa Interaktif'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CalendarDatePicker(
              initialDate: _focusedDate,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              onDateChanged: (date) {
                setState(() => _focusedDate = date);
              },
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              color: const Color(0xFF3E2723),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Weton: $weton',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFD700)),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Nilai Neptu: $neptu',
                      style: const TextStyle(
                          fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
