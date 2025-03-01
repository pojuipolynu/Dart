import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorScreen2 extends StatefulWidget {
  @override
  _CalculatorScreen2State createState() => _CalculatorScreen2State();
}

class _CalculatorScreen2State extends State<CalculatorScreen2> {
  final TextEditingController UInput = TextEditingController();
  final TextEditingController KZInput = TextEditingController();
  final TextEditingController TimeInput = TextEditingController();
  final TextEditingController SmInput = TextEditingController();
  final TextEditingController TmInput = TextEditingController();

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
                controller: UInput,
                decoration: InputDecoration(labelText: 'UInput'),
              ),
              TextField(
                controller: KZInput,
                decoration: InputDecoration(labelText: 'KZInput'),
              ),
              TextField(
                controller: TimeInput,
                decoration: InputDecoration(labelText: 'TimeInput'),
              ),
              TextField(
                controller: SmInput,
                decoration: InputDecoration(labelText: 'SmInput'),
              ),
              TextField(
                controller: TmInput,
                decoration: InputDecoration(labelText: 'TmInput'),
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
    double U = double.tryParse(UInput.text.replaceAll(',', '.')) ?? 1.0;
    double KZ = double.tryParse(KZInput.text.replaceAll(',', '.')) ?? 1.0;
    double Time = double.tryParse(TimeInput.text.replaceAll(',', '.')) ?? 1.0;
    double Sm = double.tryParse(SmInput.text.replaceAll(',', '.')) ?? 1.0;
    double Tm = double.tryParse(TmInput.text.replaceAll(',', '.')) ?? 1.0;

    double j = 1.0;
    if (1000 < Tm && Tm < 3000) {
      j = 1.6;
    } else if (3000 < Tm && Tm < 5000) {
      j = 1.4;
    } else if (5000 < Tm) {
      j = 1.2;
    }

    // Розрахунок кабелів
    double bron = (Sm / 2) / (sqrt(3) * U) / j;
    double abb = ((KZ * 1000) * sqrt(Time) / 92);

    setState(() {
      result = """
      Броньований кабель = ${(bron).toStringAsFixed(2)}, 
      АББ кабель = ${(abb).toStringAsFixed(2)}, 
      """;
    });
  }
}