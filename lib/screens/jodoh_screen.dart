import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/primbon_calculator.dart';

class JodohScreen extends StatefulWidget {
  const JodohScreen({super.key});

  @override
  State<JodohScreen> createState() => _JodohScreenState();
}

class _JodohScreenState extends State<JodohScreen> {
  DateTime? _tglPria;
  DateTime? _tglWanita;
  Map<String, String>? _hasilJodoh;

  // Fungsi untuk menampilkan pemilih tanggal
  Future<void> _selectDate(BuildContext context, bool isPria) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF3E2723), // Warna utama cokelat primbon
              onPrimary: Colors.white,
              onSurface: Color(0xFF3E2723),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isPria) {
          _tglPria = picked;
        } else {
          _tglWanita = picked;
        }
      });
    }
  }

  void _hitungJodoh() {
    if (_tglPria == null || _tglWanita == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih tanggal lahir Pria dan Wanita terlebih dahulu!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final neptuPria = PrimbonCalculator.hitungNeptu(_tglPria!);
    final neptuWanita = PrimbonCalculator.hitungNeptu(_tglWanita!);
    final hasil = PrimbonCalculator.hitungKecocokanJodoh(neptuPria, neptuWanita);

    setState(() {
      _hasilJodoh = hasil;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMMM yyyy');

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Cek Kecocokan Jodoh'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- INPUT TANGGAL LAHIR PRIA ---
            Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.male, color: Colors.blue),
                title: const Text('Tanggal Lahir Pria'),
                subtitle: Text(
                  _tglPria == null
                      ? 'Pilih tanggal lahir...'
                      : dateFormat.format(_tglPria!),
                  style: TextStyle(
                    color: _tglPria == null ? Colors.grey : Colors.black87,
                    fontWeight: _tglPria == null ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.calendar_today, color: Color(0xFF3E2723)),
                onTap: () => _selectDate(context, true),
              ),
            ),
            const SizedBox(height: 12),

            // --- INPUT TANGGAL LAHIR WANITA ---
            Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.female, color: Colors.pink),
                title: const Text('Tanggal Lahir Wanita'),
                subtitle: Text(
                  _tglWanita == null
                      ? 'Pilih tanggal lahir...'
                      : dateFormat.format(_tglWanita!),
                  style: TextStyle(
                    color: _tglWanita == null ? Colors.grey : Colors.black87,
                    fontWeight: _tglWanita == null ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.calendar_today, color: Color(0xFF3E2723)),
                onTap: () => _selectDate(context, false),
              ),
            ),
            const SizedBox(height: 24),

            // --- TOMBOL HITUNG ---
            ElevatedButton(
              onPressed: _hitungJodoh,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E2723),
                foregroundColor: const Color(0xFFFFD700),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'HITUNG JODOH',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- TAMPILAN HASIL ---
            if (_hasilJodoh != null) ...[
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
                        _hasilJodoh!['kategori'] ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E2723),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _hasilJodoh!['deskripsi'] ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.4,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
