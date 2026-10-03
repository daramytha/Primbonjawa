import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/weton_calculator.dart';
import '../providers/primbon_provider.dart';

class WetonCalculatorScreen extends StatefulWidget {
  const WetonCalculatorScreen({super.key});

  @override
  State<WetonCalculatorScreen> createState() => _WetonCalculatorScreenState();
}

class _WetonCalculatorScreenState extends State<WetonCalculatorScreen> {
  DateTime _selectedDate = DateTime.now();
  WetonResult? _result;

  @override
  void initState() {
    super.initState();
    _calculate();
  }

  void _calculate() {
    setState(() {
      _result = WetonCalculator.calculate(_selectedDate);
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
      _calculate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrimbonProvider>(context);
    final watakInfo = _result != null ? provider.getWatakInfo(_result!.totalNeptu) : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator Weton')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _pickDate,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: Text('Tanggal: ${DateFormat('dd MMMM yyyy').format(_selectedDate)}', style: const TextStyle(color: AppColors.gold)),
            ),
            const SizedBox(height: 20),
            if (_result != null) ...[
              Text('${_result!.namaHari} ${_result!.pasaran}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
              Text('Total Neptu: ${_result!.totalNeptu}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, color: AppColors.accent)),
              const SizedBox(height: 16),
              if (watakInfo != null)
                Text('Watak (${watakInfo['lakuni']}): ${watakInfo['watak']}', style: const TextStyle(fontSize: 15)),
            ]
          ],
        ),
      ),
    );
  }
}
