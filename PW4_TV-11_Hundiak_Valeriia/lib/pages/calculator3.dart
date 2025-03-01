import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorScreen3 extends StatefulWidget {
  @override
  _CalculatorScreen3State createState() => _CalculatorScreen3State();
}

class _CalculatorScreen3State extends State<CalculatorScreen3> {
  final TextEditingController RhInput = TextEditingController();
  final TextEditingController XhInput = TextEditingController();
  final TextEditingController RmInput = TextEditingController();
  final TextEditingController XmInput = TextEditingController();

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
                controller: RhInput,
                decoration: InputDecoration(labelText: 'RhInput'),
              ),
              TextField(
                controller: XhInput,
                decoration: InputDecoration(labelText: 'XhInput'),
              ),
              TextField(
                controller: RmInput,
                decoration: InputDecoration(labelText: 'RmInput'),
              ),
              TextField(
                controller: XmInput,
                decoration: InputDecoration(labelText: 'XmInput'),
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
    double Rh = double.tryParse(RhInput.text.replaceAll(',', '.')) ?? 1.0;
    double Xh = double.tryParse(XhInput.text.replaceAll(',', '.')) ?? 1.0;
    double Rm = double.tryParse(RmInput.text.replaceAll(',', '.')) ?? 1.0;
    double Xm = double.tryParse(XmInput.text.replaceAll(',', '.')) ?? 1.0;

    double Xt = (11.1 * pow(115.0, 2)) / (100 * 6.3);

    double Xsh = Xh + Xt;
    double Zsh = sqrt(pow(Rh, 2) + pow(Xsh, 2));

    double Xsh_min = Xm + Xt;
    double Zsh_min = sqrt(pow(Rm, 2) + pow(Xsh_min,2));

    // Розрахунок струму трифазного/двофазного КЗ в нормальному режимі
    double Ish_3 = (115.0 * pow(10.0, 3)) / (sqrt(3.0) * Zsh);
    double Ish_2 = Ish_3 * (sqrt(3.0) / 2);

    // Розрахунок струму трифазного/двофазного КЗ в мінімальному режимі
    double Ish_3_min = (115.0 * pow(10.0, 3)) / (sqrt(3.0) * Zsh_min);
    double Ish_2_min = Ish_3_min * (sqrt(3.0) / 2);

    double k = (pow(11.0, 2)) / (pow(115.0, 2));

    Zsh = sqrt(pow(Rh*k, 2) + pow(Xsh*k, 2));

    Zsh_min = sqrt(pow(Rm*k, 2) + pow(Xsh_min*k, 2));

    // Розрахунок дійсного струму трифазного/двофазного КЗ в нормальному режимі
    double DIsh_3 = (11.0 * pow(10.0, 3)) / (sqrt(3.0) * Zsh);
    double DIsh_2 = Ish_3 * (sqrt(3.0) / 2);

    // Розрахунок дійсного струму трифазного/двофазного КЗ в мінімальному режимі
    double DIsh_3_min = (11.0 * pow(10.0, 3)) / (sqrt(3.0) * Zsh_min);
    double DIsh_2_min = Ish_3_min * (sqrt(3.0) / 2);

    setState(() {
      result = """
      Струм трифазного КЗ.\nНормальний режим:${(Ish_3).toStringAsFixed(2)}. Мінімальний режим:${(Ish_3_min).toStringAsFixed(2)}\n
      Струм двофазного КЗ.\nНормальний режим:${(Ish_2).toStringAsFixed(2)}. Мінімальний режим:${(Ish_2_min).toStringAsFixed(2)}\n
      Дійсний струм трифазного КЗ.\nНормальний режим:${(DIsh_3).toStringAsFixed(2)}. Мінімальний режим:${(DIsh_3_min).toStringAsFixed(2)}\n
      Дійсний струм двофазного КЗ.\nНормальний режим:${(DIsh_2).toStringAsFixed(2)}. Мінімальний режим:${(DIsh_2_min).toStringAsFixed(2)}\n
      Аварійний режим на данній підстанції не передбачений.
      """;
    });
  }
}