import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorScreen1 extends StatefulWidget {
  @override
  _CalculatorScreen1State createState() => _CalculatorScreen1State();
}

class _CalculatorScreen1State extends State<CalculatorScreen1> {
  final TextEditingController efficiency = TextEditingController();
  final TextEditingController powerFactor = TextEditingController();
  final TextEditingController voltage = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController pH = TextEditingController();
  final TextEditingController kB = TextEditingController();
  final TextEditingController tg = TextEditingController();

  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Калькулятор 1')),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: efficiency,
                decoration: InputDecoration(labelText: 'Коефіцієнт корисної дії'),
              ),
              TextField(
                controller: powerFactor,
                decoration: InputDecoration(labelText: 'Коефіцієнт потужності навантаження'),
              ),
              TextField(
                controller: voltage,
                decoration: InputDecoration(labelText: 'Напруга навантаження'),
              ),
              TextField(
                controller: quantity,
                decoration: InputDecoration(labelText: 'Кількість ЕП'),
              ),
              TextField(
                controller: pH,
                decoration: InputDecoration(labelText: 'Номінальна потужність ЕП'),
              ),
              TextField(
                controller: kB,
                decoration: InputDecoration(labelText: 'Коефіцієнт використання'),
              ),
              TextField(
                controller: tg,
                decoration: InputDecoration(labelText: 'Коефіцієнт реактивної потужності'),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: get_result, child: Text('Calculate')),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: clearFields,
                child: Text('Clear'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
              SizedBox(height: 20),
              Text(result, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  void get_result() {
    double eff = double.tryParse(efficiency.text.replaceAll(',', '.')) ?? 0.92;
    double pf = double.tryParse(powerFactor.text.replaceAll(',', '.')) ?? 0.9;
    double volt = double.tryParse(voltage.text.replaceAll(',', '.')) ?? 0.38;
    double qty = double.tryParse(quantity.text.replaceAll(',', '.')) ?? 4;
    double power = double.tryParse(pH.text.replaceAll(',', '.')) ?? 20;
    double usage = double.tryParse(kB.text.replaceAll(',', '.')) ?? 0.21;
    double reactive_k = double.tryParse(tg.text.replaceAll(',', '.')) ?? 1.55;

    double totalpH = qty * power;
    double current = (qty * power) / (sqrt(3.0) * volt * pf * eff);
    double groupUsage = usage * totalpH / totalpH;
    double effectiveQty = (totalpH * totalpH) / (power*power);
    double reactivePower = totalpH * usage * reactive_k;
    double activePower = totalpH * usage;
    double totalPower = sqrt(activePower * activePower + reactivePower * reactivePower);

    setState(() {
      result = """
      Розрахунковий струм: ${current.toStringAsFixed(2)}
      Груповий коефіцієнт використання: ${groupUsage.toStringAsFixed(2)}
      Ефективна кількість ЕП: ${effectiveQty.toStringAsFixed(2)}
      Активне навантаження: ${activePower.toStringAsFixed(2)}
      Реактивне навантаження: ${reactivePower.toStringAsFixed(2)}
      Повна потужність: ${totalPower.toStringAsFixed(2)}
      """;
    });
  }

  void clearFields() {
    setState(() {
      efficiency.clear();
      powerFactor.clear();
      voltage.clear();
      quantity.clear();
      pH.clear();
      kB.clear();
      tg.clear();
      result = '';
    });
  }
}
