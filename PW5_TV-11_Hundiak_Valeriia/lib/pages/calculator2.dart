import 'package:flutter/material.dart';
import 'dart:math';

class EquipmentReliability {
  final double failureRate;
  final int averageRepairTime;
  final double frequency;
  final int? averageRecoveryTime;

  EquipmentReliability(
      this.failureRate, this.averageRepairTime, this.frequency, this.averageRecoveryTime);
}

final Map<String, EquipmentReliability> data = {
  "T-110 kV": EquipmentReliability(0.015, 100, 1.0, 43),
  "T-35 kV": EquipmentReliability(0.02, 80, 1.0, 28),
  "T-10 kV (кабельна мережа 10 кВ)": EquipmentReliability(0.005, 60, 0.5, 10),
  "T-10 kV (повітряна мережа 10 кВ)": EquipmentReliability(0.05, 60, 0.5, 10),
  "B-110 kV (елегазовий)": EquipmentReliability(0.01, 30, 0.1, 30),
  "B-10 kV (малолойний)": EquipmentReliability(0.02, 15, 0.33, 15),
  "B-10 kV (вакуумний)": EquipmentReliability(0.05, 15, 0.33, 15),
  "Збірні шини 10 кВ на 1 приєднання": EquipmentReliability(0.03, 2, 0.33, 15),
  "АВ-0,38 кВ": EquipmentReliability(0.05, 20, 1.0, 15),
  "ЕД 6,10 кВ": EquipmentReliability(0.1, 50, 0.5, 0),
  "ЕД 0,38 кВ": EquipmentReliability(0.1, 50, 0.5, 0),
  "ПЛ-110 kV": EquipmentReliability(0.007, 10, 0.167, 35),
  "ПЛ-35 kV": EquipmentReliability(0.02, 8, 0.167, 35),
  "ПЛ-10 kV": EquipmentReliability(0.02, 10, 0.167, 35),
  "КЛ-10 kV (траншея)": EquipmentReliability(0.03, 44, 1.0, 9),
  "КЛ-10 kV (кабельний канал)": EquipmentReliability(0.005, 18, 1.0, 9),
};

class CalculatorScreen2 extends StatefulWidget {
  @override
  _CalculatorScreen2State createState() => _CalculatorScreen2State();
}

class _CalculatorScreen2State extends State<CalculatorScreen2> {
  final Map<String, TextEditingController> controllers = {
    for (var key in data.keys) key: TextEditingController(text: "0")
  };

  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Калькулятор 2')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var key in controllers.keys)
              TextField(
                controller: controllers[key],
                decoration: InputDecoration(labelText: key),
                keyboardType: TextInputType.number,
              ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: get_result, child: Text('Calculate')),
            SizedBox(height: 20),
            Text(result, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  void get_result() {
    double w_0_c = 0.0;
    double tvoc = 0.0;
    double kaoc = 0.0;
    double kpos = 0.0;
    double wdk = 0.0;
    double wds = 0.0;

    controllers.forEach((key, controller) {
      int amount = int.tryParse(controller.text) ?? 0;
      if (amount > 0) {
        var entry = data[key];
        if (entry != null) {
          w_0_c += amount * entry.failureRate;
          tvoc += amount * entry.averageRepairTime * entry.failureRate;
        }
      }
    });

    if (w_0_c > 0) {
      tvoc /= w_0_c;
    }
    kaoc = (tvoc * w_0_c) / 8760;
    kpos = 1.2 * 43 / 8760;
    wdk = 2 * w_0_c * (kaoc + kpos);
    wds = wdk + 0.02;


    setState(() {
      result = """
      Частота відмов одноколової системи: ${w_0_c.toStringAsFixed(4)}
      Середня тривалість відновлення: ${tvoc.toStringAsFixed(4)}
      Коефіцієнт аварійного простою: ${kaoc.toStringAsFixed(4)}
      Коефіцієнт планового простою: ${kpos.toStringAsFixed(4)}
      Частота відмов одночасно двох кіл: ${wdk.toStringAsFixed(4)}
      Частота відмов двоколової системи: ${wds.toStringAsFixed(4)}
      """;
    });
  }
}