import 'package:flutter/material.dart';

class KalenderJawaScreen extends StatelessWidget {
  const KalenderJawaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalender Jawa Interaktif'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
      ),
      body: const Center(
        child: Text(
          'Fitur Kalender Jawa',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
