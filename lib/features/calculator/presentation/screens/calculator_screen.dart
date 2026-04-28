import 'package:flutter/material.dart';
import '../widgets/calc_button.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttons = [
      'C','()','%','÷',
      '7', '8', '9', '*',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '⌫', '0', '.', '=',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('123 + 456', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 8),
                    Text(
                      '579',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children: buttons.map((text) {
                  return CalcButton(
                    text: text,
                    onPressed: () {},
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}