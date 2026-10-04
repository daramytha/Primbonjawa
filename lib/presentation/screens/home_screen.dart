import 'package:flutter/material.dart';

// Import relative dari folder yang sama (lib/presentation/screens/)
import 'kalender_jawa_screen.dart';
import 'weton_screen.dart';
import 'jodoh_screen.dart';
import 'tafsir_mimpi_screen.dart';
import 'nogodino_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Primbon Jawa Offline'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- HEADER BANNER ---
            Card(
              color: const Color(0xFF3E2723),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 48,
                      color: Color(0xFFFFD700),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Sugeng Rawuh',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFD700),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Aplikasi ramalan & perhitungan Primbon Jawa lengkap offline.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Pilih Fitur Primbon',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E2723),
              ),
            ),
            const SizedBox(height: 12),

            // --- MENU 1: KALENDER JAWA INTERAKTIF ---
            _buildMenuCard(
              context,
              title: 'Kalender Jawa Interaktif',
              subtitle: 'Lihat pasaran & weton dalam tampilan kalender bulanan',
              icon: Icons.calendar_month,
              iconColor: Colors.deepOrange,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const KalenderJawaScreen()),
              ),
            ),

            // --- MENU 2: HITUNG WETON & NEPTU ---
            _buildMenuCard(
              context,
              title: 'Hitung Weton & Neptu',
              subtitle: 'Cek weton kelahiran, neptu, serta watak bawaan',
              icon: Icons.cake,
              iconColor: Colors.amber.shade800,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WetonScreen()),
              ),
            ),

            // --- MENU 3: CEK KECOCOKAN JODOH ---
            _buildMenuCard(
              context,
              title: 'Cek Kecocokan Jodoh',
              subtitle: 'Hitung tingkat kecocokan hubungan pasangan',
              icon: Icons.favorite,
              iconColor: Colors.pink,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const JodohScreen()),
              ),
            ),

            // --- MENU 4: TAFSIR MIMPI ---
            _buildMenuCard(
              context,
              title: 'Tafsir Mimpi',
              subtitle: 'Cari arti dan pertanda dari mimpi yang dialami',
              icon: Icons.menu_book,
              iconColor: Colors.indigo,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TafsirMimpiScreen()),
              ),
            ),

            // --- MENU 5: NOGO DINO (NAGA HARI) ---
            _buildMenuCard(
              context,
              title: 'Nogo Dino (Arah Rezeki)',
              subtitle: 'Tentukan arah keberuntungan & hindari arah pantangan',
              icon: Icons.explore,
              iconColor: Colors.teal,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NogoDinoScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.15),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E2723),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFF3E2723),
        ),
        onTap: onTap,
      ),
    );
  }
}
