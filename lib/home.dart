import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _MyState();
}

class _MyState extends State<Home> {
  GlobalKey<ScaffoldState> inputkey = GlobalKey();
  TextEditingController input = TextEditingController();
  String savedNum1 = "";
  String savedOperator = "";
  void addChar(String char) {
    if (input.text == "0" && char == "0") {
      return;
    }
    if (input.text == "0" && char != ".") {
      setState(() {
        input.text = char;
      });
      return;
    }
    if (char == ".") {
      if (input.text.contains(".")) {
        return;
      }
      if (input.text.isEmpty) {
        setState(() {
          input.text = "0.";
        });
        return;
      }
    }
    if (input.text.length < 10) {
      setState(() {
        input.text += char;
      });
      return;
    }
  }

  void delChar() {
    if (input.text.isNotEmpty) {
      setState(() {
        input.text = input.text.substring(0, input.text.length - 1);
      });
    }
  }

  void calc(String operator) {
    if (operator == "-" && input.text == "") {
      addChar("-");
      return;
    } else {
      String num1 = input.text;
      setState(() {
        savedNum1 = num1;
        savedOperator = operator;
        input.text = "";
      });
      return;
    }
  }

  void equal(String num2) {
    num2 = input.text;
    double n1 = double.parse(savedNum1);
    double n2 = double.parse(num2);
    double result = 0;
    switch (savedOperator) {
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
        if (n1 != 0 && n2 != 0) {
          result = n1 / n2;
        } else {
          result = 0;
        }
        break;
      case "%":
        if (n1 != 0 && n2 != 0) {
          result = n1 % n2;
        }
        if (n1 != 0 && n2 == 0) {
          result = n1;
        }
      case "pow":
        result = pow(n1, n2).toDouble();
    }
    if (result % 1 == 0) {
      setState(() {
        input.text = (result.toInt()).toString();
      });
    } else {
      setState(() {
        input.text = result.toString();
      });
    }
  }

  void toggleSign() {
    if (input.text.isEmpty || input.text == "0") return;
    setState(() {
      if (input.text.startsWith("-")) {
        input.text = input.text.substring(1);
      } else {
        input.text = "-${input.text}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('MY APP'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
              child: Form(
                child: TextFormField(
                  maxLength: 10,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  controller: input,
                  readOnly: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(hintText: "|", counterText: ""),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _CalcButton(
                    title: "1",
                    builder: (title) => addChar(title),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "2",
                    builder: (title) => addChar(title),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "3",
                    builder: (title) => addChar(title),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "del",
                    builder: (title) => delChar(),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "+",
                    builder: (title) => calc(title),
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _CalcButton(
                    title: "4",
                    builder: (title) => addChar(title),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "5",
                    builder: (title) => addChar(title),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "6",
                    builder: (title) => addChar(title),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "%",
                    builder: (title) => calc(title),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "x",
                    builder: (title) => calc(title),
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _CalcButton(
                    title: "7",
                    builder: (title) => addChar(title),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "8",
                    builder: (title) => addChar(title),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "9",
                    builder: (title) => addChar(title),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "pow",
                    builder: (title) => calc(title),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "-",
                    builder: (title) => calc(title),
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _CalcButton(
                    title: ".",
                    builder: (title) => addChar(title),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "0",
                    builder: (title) => addChar(title),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "-/+",
                    builder: (title) => toggleSign(),
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "C",
                    builder: (title) {
                      setState(() {
                        input.text = "";
                      });
                    },
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: _CalcButton(
                    title: "/",
                    builder: (title) => calc(title),
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _CalcButton(
                    title: "=",
                    builder: (title) => equal(title),
                    color: Colors.deepOrange,
                  ),
                ),
              ],
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
    return Container(
      margin: EdgeInsets.all(0),
      width: 90,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: MaterialButton(
        color: color,
        onPressed: () => builder(title),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
