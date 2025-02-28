import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
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
      result = "An Error has occured.";
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
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            input,
            style: TextStyle(fontSize: 36, color: Colors.white70),
          ),
          SizedBox(height: 10),
          Text(
            result,
            style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildButtons() {
    return Column(
      children: [
        buildButtonRow(["C", "", "", "/"], Colors.redAccent),
        buildButtonRow(["7", "8", "9", "*"]),
        buildButtonRow(["4", "5", "6", "-"]),
        buildButtonRow(["1", "2", "3", "+"]),
        buildButtonRow(["0", "", "=", ""], Colors.orange),
      ],
    );
  }

  Widget buildButtonRow(List<String> buttons, [Color? operatorColor]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((text) {
        bool isOperator = "+-*/=".contains(text);
        return buildButton(
          text,
          color: isOperator ? (operatorColor ?? Colors.blueAccent) : null,
        );
      }).toList(),
    );
  }

  Widget buildButton(String text, {Color? color, double fontSize = 24}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () => onButtonPressed(text),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color ?? Colors.grey[850],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
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
