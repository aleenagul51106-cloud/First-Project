import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String input = "";
  double num1 = 0;
  String operator = "";

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        output = "0";
        input = "";
        num1 = 0;
        operator = "";
      } else if (value == "+" ||
          value == "-" ||
          value == "×" ||
          value == "÷" ||
          value == "%") {
        num1 = double.parse(output);
        operator = value;
        input = "";
      } else if (value == "=") {
        double num2 = double.parse(input);
        double result = 0;

        switch (operator) {
          case "+":
            result = num1 + num2;
            break;
          case "-":
            result = num1 - num2;
            break;
          case "×":
            result = num1 * num2;
            break;
          case "÷":
            result = num2 != 0 ? num1 / num2 : 0;
            break;
          case "%":
            result = num1 % num2;
            break;
        }

        output = result.toStringAsFixed(
          result.toString().endsWith(".0") ? 0 : 2,
        );

        input = output;
      } else {
        input += value;
        output = input;
      }
    });
  }

  Widget buildButton(String text, Color color) {
    return GestureDetector(
      onTap: () => buttonPressed(text),
      child: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(2, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1E3C72),
              Color(0xff2A5298),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    output,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton("C", Colors.red),
                        buildButton("%", Colors.orange),
                        buildButton("÷", Colors.deepPurple),
                        buildButton("×", Colors.deepPurple),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton("7", Colors.blue),
                        buildButton("8", Colors.blue),
                        buildButton("9", Colors.blue),
                        buildButton("-", Colors.deepPurple),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton("4", Colors.blue),
                        buildButton("5", Colors.blue),
                        buildButton("6", Colors.blue),
                        buildButton("+", Colors.deepPurple),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton("1", Colors.blue),
                        buildButton("2", Colors.blue),
                        buildButton("3", Colors.blue),
                        buildButton("=", Colors.green),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 75),
                        buildButton("0", Colors.blue),
                        buildButton(".", Colors.blue),
                        const SizedBox(width: 75),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
