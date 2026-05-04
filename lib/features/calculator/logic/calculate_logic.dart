// calculate_logic.dart

class CalculateLogic {
  String expression = '';
  String result = '0';
  bool isPreview = true;
  bool _justEvaluated = false;

  void onButtonPressed(String text) {
    switch (text) {
      case 'C':
        expression = '';
        result = '0';
        isPreview = true; // ← reset
        _justEvaluated = false;

      case '⌫':
        if (expression.isNotEmpty) {
          expression = expression.trimRight();
          expression = expression.substring(0, expression.length - 1);
          expression = expression.trimRight();
        }
        isPreview = true; // ← về preview
        _justEvaluated = false;
        _previewResult();

      case '=':
        if (expression.isNotEmpty && result != 'Error') {
          result = _evaluate(expression);
          isPreview = false; // ← kết quả chính thức
          _justEvaluated = true;
        }

      default:
        if (_justEvaluated && _isDigit(text)) {
          expression = text;
          _justEvaluated = false;
        } else {
          if (_isOperator(text)) {
            final trimmed = expression.trimRight();
            if (trimmed.isNotEmpty &&
                _isOperator(trimmed[trimmed.length - 1])) {
              expression =
                  '${trimmed.substring(0, trimmed.length - 1).trimRight()} $text ';
            } else {
              expression = '${expression.trimRight()} $text ';
            }
          } else {
            expression += text;
            _justEvaluated = false;
          }
        }
        isPreview = true; // ← đang nhập = preview
        _previewResult();
    }
  }

  // ── preview: chỉ hiện nếu expression hợp lệ ─────────────
  void _previewResult() {
    final trimmed = expression.trimRight();

    if (trimmed.isEmpty) {
      result = '0';
      return;
    }

    // Nếu kết thúc bằng operator → tính phần trước operator cuối
    if (_isOperator(trimmed[trimmed.length - 1])) {
      // tìm vị trí operator cuối cùng
      final lastOpIndex = trimmed.lastIndexOf(RegExp(r'[+\-×÷%]'));
      if (lastOpIndex <= 0) {
        result = '0';
        return;
      }
      // cắt bỏ operator cuối: "1 + 2 +" → "1 + 2"
      final beforeLastOp = trimmed.substring(0, lastOpIndex).trimRight();
      final preview = _evaluate(beforeLastOp);
      result = preview != 'Error' ? preview : '0';
      return;
    }

    // Bình thường → tính cả expression
    final preview = _evaluate(trimmed);
    result = preview;
  }

  // ── tính toán ────────────────────────────────────────────
  String _evaluate(String expr) {
    try {
      final normalized = expr
          .trim()
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('%', '/100');

      final res = _calculate(normalized);

      if (res == res.truncateToDouble()) {
        return res.toInt().toString();
      }
      return res
          .toStringAsFixed(6)
          .replaceAll(RegExp(r'0+$'), '')
          .replaceAll(RegExp(r'\.$'), '');
    } catch (_) {
      return 'Error';
    }
  }

  double _calculate(String expr) {
    while (expr.contains('(')) {
      expr = expr.replaceAllMapped(
        RegExp(r'\(([^()]+)\)'),
        (m) => _calculate(m.group(1)!).toString(),
      );
    }

    final tokens = _tokenize(expr);

    var i = 0;
    while (i < tokens.length) {
      if (tokens[i] == '*' || tokens[i] == '/') {
        final left = double.parse(tokens[i - 1]);
        final right = double.parse(tokens[i + 1]);
        final res = tokens[i] == '*' ? left * right : left / right;
        tokens.replaceRange(i - 1, i + 2, [res.toString()]);
        i = 0;
      } else {
        i++;
      }
    }

    var res = double.parse(tokens[0]);
    for (var j = 1; j < tokens.length - 1; j += 2) {
      final op = tokens[j];
      final val = double.parse(tokens[j + 1]);
      if (op == '+') res += val;
      if (op == '-') res -= val;
    }

    return res;
  }

  List<String> _tokenize(String expr) {
    final tokens = <String>[];
    final buffer = StringBuffer();

    for (var i = 0; i < expr.length; i++) {
      final c = expr[i];

      if (c == '-' && (i == 0 || '+-*/'.contains(expr[i - 1]))) {
        buffer.write(c);
        continue;
      }

      if ('+-*/'.contains(c)) {
        if (buffer.isNotEmpty) tokens.add(buffer.toString());
        buffer.clear();
        tokens.add(c);
      } else {
        buffer.write(c);
      }
    }

    if (buffer.isNotEmpty) tokens.add(buffer.toString());
    return tokens;
  }

  bool _isOperator(String s) => '+-×÷%'.contains(s);
  bool _isDigit(String s) => RegExp(r'[0-9]').hasMatch(s);
}
