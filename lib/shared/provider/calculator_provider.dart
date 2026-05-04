import 'package:flutter/material.dart';
import 'package:flutter_tutorial_app/features/calculator/logic/calculate_logic.dart';

class CalculatorProvider extends ChangeNotifier {
  final _logic = CalculateLogic();

  // ── public state mà UI đọc ──────────────────────────────
  String get input  => _logic.expression;
  String get result => _logic.result;
  bool get isPreview => _logic.isPreview;
  
  List<String> get history => List.unmodifiable(_history);

  final List<String> _history = [];

  void onButtonPressed(String text) {
    final prevExpression = _logic.expression;
    final prevResult     = _logic.result;

    _logic.onButtonPressed(text);

    // Lưu history khi bấm "="
    if (text == '=' && prevExpression.isNotEmpty && prevResult != 'Error') {
      _history.insert(0, '$prevExpression = ${_logic.result}');
    }

    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }
}