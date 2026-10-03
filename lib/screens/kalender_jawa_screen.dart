import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:primbon_jawa_app/services/primbon_calculator.dart';

class KalenderJawaScreen extends StatefulWidget {
  const KalenderJawaScreen({super.key});

  @override
  State<KalenderJawaScreen> createState() => _KalenderJawaScreenState();
}

class _KalenderJawaScreenState extends State<KalenderJawaScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final wetonSelected = _selectedDay != null
        ? PrimbonCalculator.getWeton(_selectedDay!)
        : '';
    final neptuSelected = _selectedDay != null
        ? PrimbonCalculator.hitungNeptu(_selectedDay!)
        : 0;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Kalender Jawa Interaktif'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12.0),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            child: TableCalendar(
              firstDay: DateTime.utc(1900, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2723),
                ),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, date, events) {
                  final pasaran = PrimbonCalculator.getPasaran(date);
                  return _buildCalendarCell(date, pasaran, false, false);
                },
                todayBuilder: (context, date, events) {
                  final pasaran = PrimbonCalculator.getPasaran(date);
                  return _buildCalendarCell(date, pasaran, true, false);
                },
                selectedBuilder: (context, date, events) {
                  final pasaran = PrimbonCalculator.getPasaran(date);
                  return _buildCalendarCell(date, pasaran, false, true);
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (_selectedDay != null)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color(0xFF3E2723), width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('EEEE, dd MMMM yyyy').format(_selectedDay!),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          wetonSelected.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3E2723),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Chip(
                          backgroundColor: const Color(0xFF3E2723),
                          label: Text(
                            'Neptu: $neptuSelected',
                            style: const TextStyle(
                              color: Color(0xFFFFD700),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCalendarCell(DateTime date, String pasaran, bool isToday, bool isSelected) {
    Color textColor = Colors.black87;
    Color bgColor = Colors.transparent;

    if (isSelected) {
      bgColor = const Color(0xFF3E2723);
      textColor = const Color(0xFFFFD700);
    } else if (isToday) {
      bgColor = Colors.amber.shade100;
      textColor = const Color(0xFF3E2723);
    }

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${date.day}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            pasaran,
            style: TextStyle(
              fontSize: 9,
              color: isSelected ? const Color(0xFFFFD700) : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
