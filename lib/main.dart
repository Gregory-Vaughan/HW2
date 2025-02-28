import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';  

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";
  String result = "0";

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        result = "0";
      } else if (value == "=") {
        if (input.isNotEmpty) calculateResult();
      } else {
        // Prevents multiple consecutive operators
        if ("+-*/".contains(value) && input.isEmpty) return;
        if ("+-*/".contains(value) && "+-*/".contains(input[input.length - 1])) return;

        input += value;
      }
    });
  }

  void calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      result = eval.toString();
    } catch (e) {
      result = "Error";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildDisplay(),
          buildButtons(),
        ],
      ),
    );
  }

  Widget buildDisplay() {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            input,
            style: TextStyle(fontSize: 32, color: Colors.white70),
          ),
          Text(
            result,
            style: TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildButtons() {
    return Column(
      children: [
        buildButtonRow(["7", "8", "9", "/"]),
        buildButtonRow(["4", "5", "6", "*"]),
        buildButtonRow(["1", "2", "3", "-"]),
        buildButtonRow(["0", "C", "=", "+"]),
      ],
    );
  }

  Widget buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((text) => buildButton(text)).toList(),
    );
  }

  Widget buildButton(String text) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () => onButtonPressed(text),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: text == "C" ? Colors.red : Colors.grey[800],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
