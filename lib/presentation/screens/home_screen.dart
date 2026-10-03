import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'weton_calculator_screen.dart';
import 'jodoh_matching_screen.dart';
import 'tafsir_mimpi_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PRIMBON JAWA', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildMenuCard(
              context,
              title: 'Kalkulator Weton',
              subtitle: 'Hitung Neptu & Karakter Pasaran Lahir',
              icon: Icons.calendar_today_rounded,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WetonCalculatorScreen())),
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              title: 'Cek Kecocokan Jodoh',
              subtitle: 'Perhitungan Pethungan Pasangan Jawa',
              icon: Icons.favorite_rounded,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const JodohMatchingScreen())),
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              title: 'Kalender Jawa Interaktif',
              subtitle: 'Lihat pasaran & weton dalam tampilan kalender',
              icon: Icons.calendar_month,
              onTap: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const KalenderJawaScreen()),
  ),
),

            _buildMenuCard(
              context,
              title: 'Tafsir Mimpi & Firasat',
              subtitle: 'Pencarian Makna & Isyarat Alam',
              icon: Icons.search_rounded,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TafsirMimpiScreen())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: AppColors.gold, width: 0.8)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(backgroundColor: AppColors.primary, child: Icon(icon, color: AppColors.gold)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.accent, size: 18),
        onTap: onTap,
      ),
    );
  }
}
