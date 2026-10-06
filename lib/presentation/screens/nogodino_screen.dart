import 'package:flutter/material.dart';

class NogoDinoScreen extends StatefulWidget {
  const NogoDinoScreen({super.key});

  @override
  State<NogoDinoScreen> createState() => _NogoDinoScreenState();
}

class _NogoDinoScreenState extends State<NogoDinoScreen> {
  String _selectedHari = 'Senin';

  final Map<String, String> _dataNogoDino = {
    'Senin': 'Timur (Arah Rezeki Utama)',
    'Selasa': 'Selatan (Arah Rezeki Utama)',
    'Rabu': 'Barat (Arah Rezeki Utama)',
    'Kamis': 'Utara (Arah Rezeki Utama)',
    'Jumat': 'Timur (Arah Rezeki Utama)',
    'Sabtu': 'Selatan (Arah Rezeki Utama)',
    'Minggu': 'Barat (Arah Rezeki Utama)',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Nogo Dino (Arah Rezeki)'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedHari,
              decoration: const InputDecoration(
                labelText: 'Pilih Hari',
                border: OutlineInputBorder(),
              ),
              items: _dataNogoDino.keys
                  .map((hari) => DropdownMenuItem(
                        value: hari,
                        child: Text(hari),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedHari = val);
              },
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Icon(Icons.explore,
                        size: 48, color: Color(0xFF3E2723)),
                    const SizedBox(height: 10),
                    Text(
                      'Arah Keberuntungan Hari $_selectedHari:',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _dataNogoDino[_selectedHari]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723)),
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
