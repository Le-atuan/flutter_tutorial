import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CalcButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  static const _operators  = {'÷', '×', '-', '+', '%', '()'};
  static const _clears     = {'C', '⌫'};

  _ButtonType get _type {
    if (text == '=')             return _ButtonType.equals;
    if (_clears.contains(text))  return _ButtonType.clear;
    if (_operators.contains(text)) return _ButtonType.operator;
    return _ButtonType.number;
  }

  Color _bgColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (_type) {
      _ButtonType.equals   => const Color(0xFF86B103),
      _ButtonType.clear    => scheme.errorContainer,
      _ButtonType.operator => scheme.secondaryContainer,
      _ButtonType.number   => scheme.surfaceContainerHighest,
    };
  }

  Color _fgColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (_type) {
      _ButtonType.equals   => Colors.white,
      _ButtonType.clear    => scheme.onErrorContainer,
      _ButtonType.operator => scheme.onSecondaryContainer,
      _ButtonType.number   => scheme.onSurface,
    };
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _bgColor(context),
        foregroundColor: _fgColor(context),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}

enum _ButtonType { equals, clear, operator, number }