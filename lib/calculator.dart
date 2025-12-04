import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int number1 = 0;
  int number2 = 0;
  int sum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  number1 = int.parse(value);
                },
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  number2 = int.parse(value);
                },
              ),
              SizedBox(height: 10),
              FilledButton(
                onPressed: () {
                  sum = number1 + number2;
                  setState(() {});
                },
                child: Text("محاسبه جمع اعداد"),
              ),
              SizedBox(height: 10),
              Text("مجموع اعداد : $sum"),
            ],
          ),
        ),
      ),
    );
  }
}
