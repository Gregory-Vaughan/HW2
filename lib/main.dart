import 'package:flutter/material.dart';
import 'calculator_screen.dart'; // Import your calculator screen

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides debug banner
      title: 'Flutter Calculator',
      home: CalculatorScreen(), // Load the calculator screen
    );
  }
}
