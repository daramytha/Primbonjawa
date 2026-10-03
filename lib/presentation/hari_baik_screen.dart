import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/hari_baik_calculator.dart';
import '../../core/utils/weton_calculator.dart';

class HariBaikScreen extends StatefulWidget {
  const HariBaikScreen({super.key});

  @override
  State<HariBaikScreen> createState() => _HariBaikScreenState();
}

class _HariBaikScreenState extends State<HariBaikScreen> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final weton = WetonCalculator.calculate(_selectedDate);
    final result = HariBaikCalculator.calculate(_selectedDate);

    return Scaffold(
      appBar: AppBar(title: const Text('Hari Baik & Nogo Dino')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.event, color: AppColors.gold),
              label: Text(
                'Pilih Tanggal: ${DateFormat('dd MMMM yyyy').format(_selectedDate)}',
                style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.gold, width: 1.5),
              ),
              child: Column(
                children: [
                  Text(
                    '${weton.namaHari} ${weton.pasaran}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  Text('Total Neptu: ${weton.totalNeptu}', style: const TextStyle(color: AppColors.accent)),
                  const SizedBox(height: 16),
                  const Divider(color: AppColors.gold),
                  const SizedBox(height: 12),
                  const Text('ARAH NOGO DINO (NAGA HARI)', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.explore, color: AppColors.accent),
                      const SizedBox(width: 8),
                      Text(
                        result.arahNogoDino,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('STATUS HARI', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  const SizedBox(height: 4),
                  Text(
                    result.statusHari,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.accent),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    result.saran,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: AppColors.textDark, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
