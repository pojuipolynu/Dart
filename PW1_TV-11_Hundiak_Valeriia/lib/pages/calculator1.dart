import 'package:flutter/material.dart';

class CalculatorScreen1 extends StatefulWidget {
  @override
  _CalculatorScreen1State createState() => _CalculatorScreen1State();
}

class _CalculatorScreen1State extends State<CalculatorScreen1> {
  final TextEditingController Hydrogen = TextEditingController();
  final TextEditingController Carbon = TextEditingController();
  final TextEditingController Sulfur = TextEditingController();
  final TextEditingController Nitrogen = TextEditingController();
  final TextEditingController Oxygen = TextEditingController();
  final TextEditingController Moisture = TextEditingController();
  final TextEditingController Ash = TextEditingController();

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
                controller: Nitrogen,
                decoration: InputDecoration(labelText: 'Nitrogen'),
              ),
              TextField(
                controller: Oxygen,
                decoration: InputDecoration(labelText: 'Oxygen'),
              ),
              TextField(
                controller: Moisture,
                decoration: InputDecoration(labelText: 'Moisture'),
              ),
              TextField(
                controller: Ash,
                decoration: InputDecoration(labelText: 'Ash'),
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
    double d_nitrogen = double.tryParse(Nitrogen.text.replaceAll(',', '.')) ?? 1.0;
    double d_oxygen = double.tryParse(Oxygen.text.replaceAll(',', '.')) ?? 1.0;
    double d_moisture = double.tryParse(Moisture.text.replaceAll(',', '.')) ?? 1.0;
    double d_ashes = double.tryParse(Ash.text.replaceAll(',', '.')) ?? 1.0;

    double coefficientWtoD = 100 / (100 - d_moisture);
    double coefficientWtoC = 100 / (100 - d_moisture - d_ashes);

    double heatWorkingMass = (339 * d_carbon + 1030 * d_hydrogen - 108.8 * (d_oxygen - d_sulfur) - 25 * d_moisture) / 1000;
    double heatDryMass = (heatWorkingMass + 0.025*d_moisture) * 100 / (100 - d_moisture);
    double heatCombustibleMass = (heatWorkingMass + 0.025*d_moisture) * 100 / (100 - d_moisture - d_ashes);

    double dryhydrogen = d_hydrogen * coefficientWtoD;
    double drycarbon = coefficientWtoD * d_carbon;
    double drysulfur = coefficientWtoD * d_sulfur;
    double drynitrogen = coefficientWtoD * d_nitrogen;
    double dryoxygen = coefficientWtoD * d_oxygen;
    double dryashes = coefficientWtoD * d_ashes;


    double heathydrogen = d_hydrogen * coefficientWtoC;
    double heatcarbon = coefficientWtoC * d_carbon;
    double heatsulfur = coefficientWtoC * d_sulfur;
    double heatnitrogen = coefficientWtoC * d_nitrogen;
    double heatoxygen = coefficientWtoC * d_oxygen;


    setState(() {
      result = """
      Coefficient W to D: ${coefficientWtoD.toStringAsFixed(2)}
      Coefficient W to C: ${coefficientWtoC.toStringAsFixed(2)}

      Dry mass
      Hydrogen = ${(dryhydrogen).toStringAsFixed(2)}, Carbon = ${(drycarbon).toStringAsFixed(2)}, Sulfur = ${(drysulfur).toStringAsFixed(2)}, Nitrogen = ${(drynitrogen).toStringAsFixed(4)}, Oxygen = ${(dryoxygen).toStringAsFixed(2)}, Ashes = ${(dryashes).toStringAsFixed(2)}
      Heat mass:
      Hydrogen = ${(heathydrogen).toStringAsFixed(2)}, Carbon = ${(heatcarbon).toStringAsFixed(2)}, Sulfur = ${(heatsulfur).toStringAsFixed(2)}, Nitrogen = ${(heatnitrogen).toStringAsFixed(4)}, Oxygen = ${(heatoxygen).toStringAsFixed(2)}


      Heat working mass: ${heatWorkingMass.toStringAsFixed(2)} 
      Heat dry mass: ${heatDryMass.toStringAsFixed(2)} 
      Heat combustible mass: ${heatCombustibleMass.toStringAsFixed(2)} 
      """;
    });
  }
}