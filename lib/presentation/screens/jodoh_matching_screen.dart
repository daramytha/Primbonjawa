import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/weton_calculator.dart';
import '../providers/primbon_provider.dart';

class JodohMatchingScreen extends StatefulWidget {
  const JodohMatchingScreen({super.key});

  @override
  State<JodohMatchingScreen> createState() => _JodohMatchingScreenState();
}

class _JodohMatchingScreenState extends State<JodohMatchingScreen> {
  DateTime _dateP1 = DateTime(1998, 5, 20);
  DateTime _dateP2 = DateTime(2000, 8, 15);
  Map<String, dynamic>? _result;

  void _calculate() {
    final p1 = WetonCalculator.calculate(_dateP1);
    final p2 = WetonCalculator.calculate(_dateP2);
    final provider = Provider.of<PrimbonProvider>(context, listen: false);
    setState(() {
      _result = provider.calculateJodoh(p1, p2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cek Kecocokan Jodoh')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text('HITUNG JODOH', style: TextStyle(color: AppColors.gold)),
            ),
            const SizedBox(height: 20),
            if (_result != null) ...[
              Text(_result!['category'], style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primary)),
              const SizedBox(height: 8),
              Text(_result!['meaning'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)),
            ]
          ],
        ),
      ),
    );
  }
}
