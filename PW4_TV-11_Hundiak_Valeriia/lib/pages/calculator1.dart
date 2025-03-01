import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorScreen1 extends StatefulWidget {
  @override
  _CalculatorScreen1State createState() => _CalculatorScreen1State();
}

class _CalculatorScreen1State extends State<CalculatorScreen1> {
  final TextEditingController KzuInput = TextEditingController();

  String result = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Калькулятор')),
      body: SingleChildScrollView(
        keyboardDismissBehavior:
        ScrollViewKeyboardDismissBehavior
            .onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: KzuInput,
                decoration: InputDecoration(labelText: 'KzuInput'),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: get_result, child: Text('Calculate')),
              SizedBox(height: 20),
              Text(result, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  void get_result() {
    double Kzu = double.tryParse(KzuInput.text.replaceAll(',', '.')) ?? 1.0;
    double Uc = 10.5;

    double strum = Uc / (sqrt(3.0) * (pow(Uc, 2) / Kzu) + ((Uc / 100) * (pow(Uc, 2) / 6.3)));


    setState(() {
      result = """
      Струм трифазного КЗ: ${strum.toStringAsFixed(2)}
      """;
    });
  }
}