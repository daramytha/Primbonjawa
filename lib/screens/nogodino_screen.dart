import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/primbon_calculator.dart';

class NogoDinoScreen extends StatefulWidget {
  const NogoDinoScreen({super.key});

  @override
  State<NogoDinoScreen> createState() => _NogoDinoScreenState();
}

class _NogoDinoScreenState extends State<NogoDinoScreen> {
  DateTime _selectedDate = DateTime.now();

  // Data Arah Nogo Dino berdasarkan Pasaran/Hari Jawa
  final Map<String, Map<String, String>> _nogoDinoData = {
    'Legi': {
      'arah_baik': 'Timur',
      'arah_hindari': 'Barat',
      'deskripsi': 'Arah rezeki berada di Timur. Hindari bepergian atau memulai urusan penting ke arah Barat.',
    },
    'Pahing': {
      'arah_baik': 'Selatan',
      'arah_hindari': 'Utara',
      'deskripsi': 'Arah keberuntungan di Selatan. Hindari menuju ke arah Utara.',
    },
    'Pon': {
      'arah_baik': 'Barat',
      'arah_hindari': 'Timur',
      'deskripsi': 'Arah rezeki utama di Barat. Jangan menuju ke arah Timur.',
    },
    'Wage': {
      'arah_baik': 'Utara',
      'arah_hindari': 'Selatan',
      'deskripsi': 'Arah keberuntungan di Utara. Hindari arah Selatan.',
    },
    'Kliwon': {
      'arah_baik': 'Tengah / Segala Arah',
      'arah_hindari': 'Tidak Ada khusus',
      'deskripsi': 'Pusat energi di Tengah. Baik ke semua arah namun tetap utamakan kehati-hatian.',
    },
  };

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF3E2723),
              onPrimary: Colors.white,
              onSurface: Color(0xFF3E2723),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, dd MMMM yyyy');
    final pasaran = PrimbonCalculator.getPasaran(_selectedDate);
    final wetonInfo = PrimbonCalculator.getWeton(_selectedDate);
    final dataNogo = _nogoDinoData[pasaran] ?? _nogoDinoData['Kliwon']!;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Nogo Dino (Naga Hari)'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- PEMILIH TANGGAL ---
            Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.explore, color: Color(0xFF3E2723)),
                title: const Text('Pilih Tanggal Cari Arah'),
                subtitle: Text(
                  '${dateFormat.format(_selectedDate)} ($wetonInfo)',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),
                trailing: const Icon(Icons.calendar_today, color: Color(0xFF3E2723)),
                onTap: () => _selectDate(context),
              ),
            ),
            const SizedBox(height: 24),

            // --- KARTU HASIL NOGO DINO ---
            Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFF3E2723), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'PASARAN: ${pasaran.toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2723),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Divider(height: 24, thickness: 1),

                    // Arah Baik / Rezeki
                    Row(
                      children: [
                        const Icon(Icons.navigation, color: Colors.green, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Arah Baik (Mencari Rezeki):',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                dataNogo['arah_baik']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Arah Pantangan / Hindari
                    Row(
                      children: [
                        const Icon(Icons.dangerous, color: Colors.red, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Arah Pantangan (Pati / Hindari):',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                dataNogo['arah_hindari']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 28, thickness: 1),

                    // Petunjuk & Deskripsi
                    Text(
                      dataNogo['deskripsi']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.4,
                        color: Colors.black87,
                      ),
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
