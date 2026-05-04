import 'package:flutter/material.dart';
import 'package:flutter_tutorial_app/shared/provider/calculator_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/calc_button.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalculatorProvider>();
    
    final buttons = [
      'C','()','%','÷',
      '7','8','9','×',
      '4','5','6','-',
      '1','2','3','+',
      '⌫','0','.','=',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, '/history'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16,24,16,24),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16,24,16,24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      provider.input.isEmpty ? '' : provider.input,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      provider.result,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: provider.isPreview ? Colors.grey : Colors.black,
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
                    onPressed: () => context
                        .read<CalculatorProvider>()
                        .onButtonPressed(text),
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