import 'package:flutter/material.dart';
import "dart:math";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LB1',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController CoalWeight = TextEditingController();
  final TextEditingController MazutWeight = TextEditingController();
  final TextEditingController GasWeight = TextEditingController();
  final TextEditingController QCoal = TextEditingController();

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
                controller: CoalWeight,
                decoration: InputDecoration(labelText: 'CoalWeight'),
              ),
              TextField(
                controller: MazutWeight,
                decoration: InputDecoration(labelText: 'MazutWeight'),
              ),
              TextField(
                controller: GasWeight,
                decoration: InputDecoration(labelText: 'GasWeight'),
              ),
              TextField(
                controller: QCoal,
                decoration: InputDecoration(labelText: 'QCoal'),
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
    double coalweight = double.tryParse(CoalWeight.text.replaceAll(',', '.')) ?? 1.0;
    double mazutweight = double.tryParse(MazutWeight.text.replaceAll(',', '.')) ?? 1.0;
    double gasweight = double.tryParse(GasWeight.text.replaceAll(',', '.')) ?? 1.0;
    double qcoal = double.tryParse(QCoal.text.replaceAll(',', '.')) ?? 1.0;

    double gasDensity = 0.723;
    double gas = gasweight * gasDensity;

    double kCoal = pow(10, 6) / qcoal * 0.8 * 25.2 / (100 - 1.5) * (1 - 0.985);
    double eCoal = pow(10, -6) * kCoal * qcoal * coalweight;

    double kmazut = pow(10, 6) / 39.48 * 1 * 0.15 / (100 - 0) * (1 - 0.985);
    double emazut = pow(10, -6) * kmazut * 39.48 * mazutweight;

    double kGas = pow(10, 6) / 33.08 * 0 * 0 / (100 - 0) * (1 - 0.985);
    double eGas = pow(10, -6) * kGas * 33.08 * gas;



    setState(() {
      result = """
       Для заданого енергоблоку і відповідним умовам роботи:
            1. Показник емісії твердих частинок при спалюванні вугілля становитиме: ${kCoal.toStringAsFixed(2)} г/ГДж;
            2. Валовий викид при спалюванні вугілля становитиме:  ${eCoal.toStringAsFixed(2)} т.;
            3. Показник емісії твердих частинок при спалюванні мазуту становитиме:  ${kmazut.toStringAsFixed(2)} г/ГДж;
            4. Валовий викид при спалюванні мазуту становитиме:  ${emazut.toStringAsFixed(2)} т.;
            5. Показник емісії твердих частинок при спалюванні природного газу становитиме:  ${kGas.toStringAsFixed(2)}
            г/ГДж;
            6. Валовий викид при спалюванні природного газу становитиме:  ${eGas.toStringAsFixed(2)} т..
      """;
    });
  }
}