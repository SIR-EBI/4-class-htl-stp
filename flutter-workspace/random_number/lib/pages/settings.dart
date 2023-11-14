import 'dart:math';

import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Map data = {};


  double minValue = 0;
  double maxValue = 0;

  double _startValue = 10;
  double _endValue = 20;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;

    minValue = data["min"];
    maxValue = data["max"];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              "/",
              arguments: {
                "min": _startValue,
                "max": _endValue,
              },
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "select a range for the number generation",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
          RangeSlider(
            min: 0.0,
            max: 100.0,
            divisions: 100,
            labels: RangeLabels(
              _startValue.round().toString(),
              _endValue.round().toString(),
            ),
            values: RangeValues(
              _startValue,
              _endValue,
            ),
            onChanged: (values) {
              setState(() {
                _startValue = values.start;
                _endValue = values.end;
              });
            },
          ),
        ],
      ),
    );
  }
}
