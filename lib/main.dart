import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_colors.dart';
import 'presentation/providers/primbon_provider.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const PrimbonJawaApp());
}

class PrimbonJawaApp extends StatelessWidget {
  const PrimbonJawaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PrimbonProvider()..initData(),
      child: MaterialApp(
        title: 'Primbon Jawa',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.accent,
            surface: AppColors.surface,
          ),
          fontFamily: 'Serif',
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.gold,
            centerTitle: true,
            elevation: 2,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
