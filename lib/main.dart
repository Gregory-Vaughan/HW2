import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";
  String result = "0";

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
        onTap: () {
          // Does nothing RN
        },
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
