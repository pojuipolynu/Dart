import 'package:flutter/material.dart';

class CalculatorScreen2 extends StatefulWidget {
  @override
  _CalculatorScreen2State createState() => _CalculatorScreen2State();
}

class _CalculatorScreen2State extends State<CalculatorScreen2> {
  final TextEditingController Hydrogen = TextEditingController();
  final TextEditingController Carbon = TextEditingController();
  final TextEditingController Sulfur = TextEditingController();
  final TextEditingController Oxygen = TextEditingController();
  final TextEditingController Venadii = TextEditingController();
  final TextEditingController Q = TextEditingController();
  final TextEditingController Ash = TextEditingController();
  final TextEditingController Moisture = TextEditingController();

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
                controller: Hydrogen,
                decoration: InputDecoration(labelText: 'Hydrogen'),
              ),
              TextField(
                controller: Carbon,
                decoration: InputDecoration(labelText: 'Carbon'),
              ),
              TextField(
                controller: Sulfur,
                decoration: InputDecoration(labelText: 'Sulfur'),
              ),
              TextField(
                controller: Oxygen,
                decoration: InputDecoration(labelText: 'Oxygen'),
              ),
              TextField(
                controller: Venadii,
                decoration: InputDecoration(labelText: 'Venadii'),
              ),
              TextField(
                controller: Q,
                decoration: InputDecoration(labelText: 'Q'),
              ),
              TextField(
                controller: Ash,
                decoration: InputDecoration(labelText: 'Ash'),
              ),
              TextField(
                controller: Moisture,
                decoration: InputDecoration(labelText: 'Moisture'),
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
    double d_hydrogen = double.tryParse(Hydrogen.text.replaceAll(',', '.')) ?? 1.0;
    double d_carbon = double.tryParse(Carbon.text.replaceAll(',', '.')) ?? 1.0;
    double d_sulfur = double.tryParse(Sulfur.text.replaceAll(',', '.')) ?? 1.0;
    double d_oxygen = double.tryParse(Oxygen.text.replaceAll(',', '.')) ?? 1.0;
    double d_venadii = double.tryParse(Venadii.text.replaceAll(',', '.')) ?? 1.0;
    double d_q = double.tryParse(Q.text.replaceAll(',', '.')) ?? 1.0;
    double d_ashes = double.tryParse(Ash.text.replaceAll(',', '.')) ?? 1.0;
    double d_moisture = double.tryParse(Moisture.text.replaceAll(',', '.')) ?? 1.0;

    double m = (100 - d_moisture - d_ashes) / 100;

    double workingMassCarbon = d_carbon * m;
    double workingMassSulfur = d_sulfur * m;
    double workingMassOxygen = d_oxygen * m;
    double workingMassVenadii = d_venadii * m;
    double workingMassAsh = d_ashes * m;
    double workingMassHydrogen = d_hydrogen * m;

    double qWorkingMass = d_q * ((100 - d_moisture - d_ashes) / 100) - 0.025 * d_moisture;


    setState(() {
      result = """
      Working Mass
      Hydrogen = ${(workingMassHydrogen).toStringAsFixed(2)}, 
      Carbon = ${(workingMassCarbon).toStringAsFixed(2)}, 
      Sulfur = ${(workingMassSulfur).toStringAsFixed(2)}, 
      Q = ${(qWorkingMass).toStringAsFixed(4)}, 
      Oxygen = ${(workingMassOxygen).toStringAsFixed(2)},
      Venadii = ${(workingMassVenadii).toStringAsFixed(2)},
      Ashes = ${(workingMassAsh).toStringAsFixed(2)},
      """;
    });
  }
}