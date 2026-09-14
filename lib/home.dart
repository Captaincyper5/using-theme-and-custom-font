import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _MyState();
}

class _MyState extends State<Home> {
  final TextEditingController _input = TextEditingController();
  final TextEditingController _input2 = TextEditingController();
  String _savedNum1 = "";
  String _savedOperator = "";
  void _addChar(String char) {
    if (_input.text == "0" && char == "0") return;
    if (_input.text == "0" && char != ".") {
      setState(() {
        _input.text = char;
        _input2.text = char;
      });
    }
    if (char == ".") {
      if (_input.text.contains(".")) return;
      if (_input.text.isEmpty) {
        setState(() {
          _input.text = "0.";
          _input2.text = "0.";
        });
      }
    }
    if (_input.text.length < 10) {
      setState(() {
        _input.text += char;
        _input2.text += char;
      });
    }
  }

  void _delChar() {
    setState(() {
      if (_input.text.isNotEmpty) {
        _input.text = _input.text.substring(0, _input.text.length - 1);
        _input2.text = _input.text.substring(0, _input2.text.length - 1);
      }
    });
  }

  String _formResult(double num) {
    if (num == num.toInt()) {
      return num.toInt().toString();
    }
    return double.parse(num.toStringAsFixed(4)).toString();
  }

  void _calc(String operator) {
    if (operator == "-" && _input.text == "") {
      _addChar("-");
      return;
    } else {
      if (_savedNum1.isEmpty && _input.text.isEmpty) return;
      if (_savedNum1.isNotEmpty &&
          _input.text.isNotEmpty &&
          _savedOperator.isNotEmpty) {
        _calculate();
      } else if (_input.text.isNotEmpty) {
        _savedNum1 = _input.text;
      }
      setState(() {
        _savedOperator = operator;
        _input.text = "";
        if (_input2.text.endsWith("=")) {
          _input2.text = _input2.text.substring(0, _input2.text.length - 1);
        }
        _input2.text += operator;
        _input.text = "";
      });
    }
  }

  void _equal(String num2) {
    if (_savedNum1.isEmpty || _input.text.isEmpty || _savedOperator.isEmpty) {
      return;
    }
    _calculate();
    setState(() {
      if (!_input2.text.endsWith("=")) {
        _input2.text += "=";
      }
      _savedOperator = "";
    });
  }

  void _calculate() {
    double n1 = double.tryParse(_savedNum1) ?? 0.0;
    double n2 = double.tryParse(_input.text) ?? 0.0;
    double result = 0.0;
    switch (_savedOperator) {
      case "+":
        result = n1 + n2;
        break;
      case "-":
        result = n1 - n2;
        break;
      case "x":
        result = n1 * n2;
        break;
      case "/":
        result = n2 != 0 ? n1 / n2 : 0.0;
        break;
      case "%":
        if (n1 != 0 && n2 != 0) {
          result = n1 % n2;
        }
        if (n2 == 0) {
          result = n1;
        }
        break;
    }
    String formattedResult = _formResult(result);
    _savedNum1 = formattedResult;
    _input.text = formattedResult;
  }

  void _toggleSign() {
    if (_input.text.isEmpty || _input.text == "0") return;
    setState(() {
      if (_input.text.startsWith("-")) {
        _input.text = _input.text.substring(1);
      } else {
        _input.text = "-${_input.text}";
      }
    });
  }

  late List<Map<String, dynamic>> buttons = [
    {
      'title': 'C',
      'color': Colors.red,
      'function': (title) => setState(() {
        _input.text = "";
        _input2.text = "";
        _savedNum1 = "";
        _savedOperator = "";
      }),
    },
    {'title': '⌫', 'color': Colors.orange, 'function': (title) => _delChar()},
    {
      'title': '+/-',
      'color': Colors.orange,
      'function': (title) => _toggleSign(),
    },
    {'title': '/', 'color': Colors.orange, 'function': (title) => _calc("/")},

    {'title': '7', 'function': (title) => _addChar("7")},
    {'title': '8', 'function': (title) => _addChar("8")},
    {'title': '9', 'function': (title) => _addChar("9")},
    {'title': 'x', 'color': Colors.orange, 'function': (title) => _calc("x")},

    {'title': '4', 'function': (title) => _addChar("4")},
    {'title': '5', 'function': (title) => _addChar("5")},
    {'title': '6', 'function': (title) => _addChar("6")},
    {'title': '-', 'color': Colors.orange, 'function': (title) => _calc("-")},

    {'title': '1', 'function': (title) => _addChar("1")},
    {'title': '2', 'function': (title) => _addChar("2")},
    {'title': '3', 'function': (title) => _addChar("3")},
    {'title': '+', 'color': Colors.orange, 'function': (title) => _calc("+")},

    {'title': '0', 'function': (title) => _addChar("0")},
    {'title': '.', 'function': (title) => _addChar(".")},
    {
      'title': '=',
      'color': Colors.deepOrange,
      'function': (title) => _equal("="),
    },
    {'title': '%', 'color': Colors.orange, 'function': (title) => _calc("%")},
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('C a l c u l a t o r'),
              SizedBox(width: 135),
              Icon(Icons.calculate, size: 40),
            ],
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.all(0),
              alignment: Alignment.bottomRight,
              child: TextFormField(
                controller: _input2,
                readOnly: true,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "0",
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.none,
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
              alignment: Alignment.bottomRight,
              child: TextFormField(
                controller: _input,
                readOnly: true,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "0",
                ),
              ),
            ),
            // لوحة الأزرار
            Expanded(
              flex: 2,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.32,
                ),
                itemBuilder: (context, i) {
                  return _CalcButton(
                    title: buttons[i]['title'],
                    color: buttons[i]['color'] ?? Colors.white,
                    builder: buttons[i]['function'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalcButton extends StatelessWidget {
  const _CalcButton({
    required this.title,
    required this.builder,
    this.color = Colors.white,
  });
  final String title;
  final void Function(String) builder;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      shape: CircleBorder(side: BorderSide(color: Colors.black, width: 1)),
      onPressed: () => builder(title),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
