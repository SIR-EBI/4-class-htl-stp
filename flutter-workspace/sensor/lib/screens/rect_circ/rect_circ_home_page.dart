import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sensor_plus/screens/rect_circ/rect_circ_manager.dart';
import 'package:flutter_sensor_plus/screens/rect_circ/rect_circ_settings_page.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(MaterialApp(
        initialRoute: "/home",
        routes: {
          "/home": (context) => const RectCircHomePage(),
          "/setting": (context) => const RectCircSettingsPage(),
        },
      )));
}

class RectCircHomePage extends StatefulWidget {
  const RectCircHomePage({super.key});

  @override
  State<RectCircHomePage> createState() => _RectCircHomePageState();
}

class _RectCircHomePageState extends State<RectCircHomePage> {
  final double _rectangleSize = 200;
  final double _circleSize = 50;
  final double innerOffset = 6;

  double _circleX = 0;
  double _circleY = 0;

  @override
  void initState() {
    super.initState();

    _circleX = _rectangleSize / 2 - _circleSize / 2;
    _circleY = _rectangleSize / 2 - _circleSize / 2;

    if (mounted) {
      setState(() {});
    }

    _addSensorListener();
  }

  void _addSensorListener() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      double helpX = _circleX + event.x * RectCircManager.factor;
      double helpY = _circleY + event.y * RectCircManager.factor;

      if (helpX-innerOffset < 0) {
        _circleX = innerOffset;
      } else if (helpX+innerOffset > _rectangleSize - _circleSize) {
        _circleX = _rectangleSize - _circleSize - innerOffset;
      } else {
        _circleX = helpX;
      }

      if (helpY-innerOffset < 0) {
        _circleY = innerOffset;
      } else if (helpY+innerOffset > _rectangleSize - _circleSize) {
        _circleY = _rectangleSize - _circleSize - innerOffset;
      } else {
        _circleY = helpY;
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xffe0e5ec),
        /**
         * app bar
         */
        appBar: AppBar(
          backgroundColor: const Color(0xffe0e5ec),
          elevation: 0,
          title: const Text(
            "Rectangle Circle Home",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            /**
             * reset button
             */
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () {
                _circleX = _rectangleSize / 2 - _circleSize / 2;
                _circleY = _rectangleSize / 2 - _circleSize / 2;
                setState(() {});
              },
            ),
          ],
        ),
        /**
         * body
         */
        body: Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_circleSize / 2),
              color: const Color(0xffe0e5ec),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(-4, -4),
                  blurRadius: 4,
                  color: Colors.white,
                  inset: true,
                ),
                BoxShadow(
                  offset: Offset(4, 4),
                  blurRadius: 4,
                  color: Color(0xffa3b1c6),
                  inset: true,
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  // test if circle is not moving out of the rectangle
                  left: _circleY,
                  top: _circleX,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: RectCircManager.circleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        /**
         * bottom floating action button
         */
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, "/setting");
            setState(() {});
          },
          backgroundColor: const Color(0xffe0e5ec),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.settings),
          ),
        ),
      ),
    );
  }
}
