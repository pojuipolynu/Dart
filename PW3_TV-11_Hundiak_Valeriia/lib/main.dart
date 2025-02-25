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
  final TextEditingController P = TextEditingController();
  final TextEditingController Q1 = TextEditingController();
  final TextEditingController Q2 = TextEditingController();
  final TextEditingController B = TextEditingController();

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
                controller: P,
                decoration: InputDecoration(labelText: 'P'),
              ),
              TextField(
                controller: Q1,
                decoration: InputDecoration(labelText: 'Q1'),
              ),
              TextField(
                controller: Q2,
                decoration: InputDecoration(labelText: 'Q2'),
              ),
              TextField(
                controller: B,
                decoration: InputDecoration(labelText: 'B'),
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
    double p = double.tryParse(P.text.replaceAll(',', '.')) ?? 1.0;
    double q1 = double.tryParse(Q1.text.replaceAll(',', '.')) ?? 1.0;
    double q2 = double.tryParse(Q2.text.replaceAll(',', '.')) ?? 1.0;
    double b = double.tryParse(B.text.replaceAll(',', '.')) ?? 1.0;

    Triple<double, double, double> resultDataQ1 = calculateProfitAndPenalty(p, b, q1);
    Triple<double, double, double> resultDataQ2 = calculateProfitAndPenalty(p, b, q2);

    setState(() {
      result = """
        Результат для Q1:
        Прибуток від енергії: ${resultDataQ1.first.toStringAsFixed(2)} грн
        Штраф: ${resultDataQ1.second.toStringAsFixed(2)} грн
        Фінальний результат: ${resultDataQ1.third.toStringAsFixed(2)}"})

        Результат для Q2:
        Прибуток від енергії: ${resultDataQ2.first.toStringAsFixed(2)} грн
        Штраф: ${resultDataQ2.second.toStringAsFixed(2)} грн
        Фінальний результат: ${resultDataQ2.third.toStringAsFixed(2)})
        """;
    });
  }
}

double calculateEnergyShare(double Pc, double q) {
  double delta = Pc * 0.05;
  double lowerBound = Pc - delta;
  double upperBound = Pc + delta;
  double step = 0.001;

  double integral = 0.0;
  for (double p = lowerBound; p < upperBound; p += step) {
    double pd = (1 / (q * sqrt(2 * pi))) * exp(-pow(p - Pc, 2) / (2 * pow(q, 2)));
    integral += pd * step;
  }
  return integral;
}

Triple<double, double, double> calculateProfitAndPenalty(double Pc, double cost, double q) {
  double energyShare = calculateEnergyShare(Pc, q);
  double energyWithoutImbalance = (Pc * 24 * energyShare).roundToDouble();
  double profit = energyWithoutImbalance * cost * 1000;
  double energyWithImbalance = (Pc * 24 * (1 - energyShare)).roundToDouble();
  double penalty = energyWithImbalance * cost * 1000;
  return Triple(profit, penalty, profit - penalty);
}

class Triple<T1, T2, T3> {
  final T1 first;
  final T2 second;
  final T3 third;

  Triple(this.first, this.second, this.third);
}