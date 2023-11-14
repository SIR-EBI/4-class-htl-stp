import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../domain/sun_manager.dart';

class CityLineChart extends StatelessWidget {
  final List<SunManager> downTimeList;
  final List<SunManager> upTimeList;

  const CityLineChart({
    Key? key,
    required this.downTimeList,
    required this.upTimeList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        backgroundColor: Colors.black38,
        minX: 0,
        minY: 0,
        maxX: 366,
        maxY: 24,
        lineBarsData: [
          LineChartBarData(
            spots: upTimeList.map((obj) => FlSpot(obj.day, obj.time)).toList(),
            isCurved: false,
            color: Colors.red,
          ),
          LineChartBarData(
            spots:
                downTimeList.map((obj) => FlSpot(obj.day, obj.time)).toList(),
            isCurved: false,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
