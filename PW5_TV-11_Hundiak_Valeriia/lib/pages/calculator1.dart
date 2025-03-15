import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorScreen1 extends StatefulWidget {
  @override
  _CalculatorScreen1State createState() => _CalculatorScreen1State();
}

class _CalculatorScreen1State extends State<CalculatorScreen1> {
  final TextEditingController Omega = TextEditingController();
  final TextEditingController Ts = TextEditingController();
  final TextEditingController Pm = TextEditingController();
  final TextEditingController Tm = TextEditingController();
  final TextEditingController Zavar = TextEditingController();
  final TextEditingController Zplan = TextEditingController();
  final TextEditingController Kp = TextEditingController();


  String result = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Калькулятор 1')),
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
                controller: Omega,
                decoration: InputDecoration(labelText: 'Частота відмов'),
              ),
              TextField(
                controller: Ts,
                decoration: InputDecoration(labelText: 'Середній час відновлення трансформатора напругою 35 кВ'),
              ),
              TextField(
                controller: Pm,
                decoration: InputDecoration(labelText: 'Потужність'),
              ),
              TextField(
                controller: Tm,
                decoration: InputDecoration(labelText: 'Очікуваний час простою'),
              ),
              TextField(
                controller: Zavar,
                decoration: InputDecoration(labelText: 'Збитки у разі аварійного переривання'),
              ),
              TextField(
                controller: Zplan,
                decoration: InputDecoration(labelText: 'Збитки у разі запланованого переривання'),
              ),
              TextField(
                controller: Kp,
                decoration: InputDecoration(labelText: 'Середній час планового простою'),
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
    double omegaValue = double.tryParse(Omega.text.replaceAll(',', '.')) ?? 0.01;
    double tSValue = double.tryParse(Ts.text.replaceAll(',', '.')) ?? 0.045;
    double pMValue = double.tryParse(Pm.text.replaceAll(',', '.')) ?? 5120;
    double tMValue = double.tryParse(Tm.text.replaceAll(',', '.')) ?? 6451;
    double zAvarValue = double.tryParse(Zavar.text.replaceAll(',', '.')) ?? 23.6;
    double zPlanValue = double.tryParse(Zplan.text.replaceAll(',', '.')) ?? 17.6;
    double kPValue = double.tryParse(Kp.text.replaceAll(',', '.')) ?? 0.004;

    double mWnedAValue = omegaValue * tSValue * pMValue * tMValue;
    double mWnedPValue = kPValue * pMValue * tMValue;
    double mZValue = zAvarValue * mWnedAValue + zPlanValue * mWnedPValue;

    setState(() {
      result = """
      Очікувана відсутність енергопостачання в надзвичайних ситуаціях: ${mWnedAValue.toStringAsFixed(2)}
      Очікуваний дефіцит енергії для запланованих: ${mWnedPValue.toStringAsFixed(2)}
      Загальна очікувана вартість перерв у роботі: ${mZValue.toStringAsFixed(2)}
      """;
    });
  }
}