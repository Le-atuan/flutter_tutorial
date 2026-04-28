import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shared/provider/calculator_provider.dart';
import 'features/calculator/presentation/screens/calculator_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculator App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFEC1C2A),
          ),
        ),
        home: const CalculatorScreen(),
      ),
    );
  }
}