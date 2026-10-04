import 'package0/flutter/material.dart';

class NogoDinoScreen extends StatelessWidget {
  const NogoDinoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nogo Dino (Arah Rezeki)'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
      ),
      body: const Center(
        child: Text(
          'Fitur Nogo Dino',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
