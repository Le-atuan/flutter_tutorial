import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  String input = '';
  String result = '0';

  List<String> history = [];

  /// thêm ký tự
  void add(String value) {
    input += value;
    notifyListeners();
  }

  /// clear
  void clear() {
    input = '';
    result = '0';
    notifyListeners();
  }

  /// tính toán (demo)
  void calculate() {
    result = input; 
    history.insert(0, '$input = $result');
    notifyListeners();
  }
}