import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const WaterLevelApp()));
}

class WaterLevelApp extends StatefulWidget {
  const WaterLevelApp({super.key});

  @override
  State<WaterLevelApp> createState() => _WaterLevelAppState();
}

class _WaterLevelAppState extends State<WaterLevelApp> {
  double _x = 0.0;
  double _y = 0.0;
  double _z = 0.0;

  @override
  void initState() {
    super.initState();

    addSensorListener();
  }

  void addSensorListener() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (mounted) {
        setState(() {
          _x = event.x;
          _y = event.y;
          _z = event.z;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xffe0e5ec),
        appBar: AppBar(
          backgroundColor: const Color(0xffe0e5ec),
          elevation: 0,
          title: const Text(
            'Wasserwaage',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(-4, -4),
                        blurRadius: 4,
                        color: Colors.grey[100]!,
                      ),
                      const BoxShadow(
                        offset: Offset(4, 4),
                        blurRadius: 4,
                        color: Color(0xffa3b1c6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: SizedBox(
                      width: 300.0,
                      height: 300.0,
                      child: Image.asset("assets/circle.png"),
                    ),
                  ),
                ),
              ),
              Center(
                child: Transform(
                  transform: Matrix4.rotationZ(_calculateTiltAngle()),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      const Center(
                        child: Icon(
                          Icons.arrow_forward,
                          size: 100.0,
                          color: Colors.blue,
                        ),
                      ),
                      Center(
                        child: Container(
                          color: Colors.blue,
                          width: 300.0,
                          height: 1.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateTiltAngle() {
    double norm = sqrt(_x * _x + _y * _y + _z * _z);
    double xNorm = _x / norm;
    double yNorm = _y / norm;
    double tiltAngle = -atan2(xNorm, yNorm);

    return pi - tiltAngle;
  }
}
